$ErrorActionPreference = "Stop"
$path = "c:\Users\4-410\Desktop\0504\corporate-site"
$files = Get-ChildItem -Path $path -Filter "*.html"

$newGrid = @"
<div class="subpage-content adaptive-grid fade-up-element">
  <div class="grid-text-area">
    <h2>첨단 솔루션 기술 정보</h2>
    <p>SGC가 제공고하는 제품과 인프라는 최고 수준의 품질을 보장합니다. 글로벌 표준 기구 인증 시스템을 바탕으로 생산된 로보틱스 라인업을 다이내믹한 3D 가상 그래픽과 함께 확인하실 수 있습니다.</p>
  </div>
  <div class="grid-media-area">
    <div class="media-placeholder focusable" tabindex="0">
      <span class="play-icon">▶</span>
      <p>3D 로봇 모형 / 비디오 영역</p>
    </div>
  </div>
</div>
</div>
</section>
"@

$count = 0
foreach ($f in $files) {
    # Read file content safely
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    
    # 1. Replace Header
    $content = [regex]::Replace($content, '(?s)<!-- TOP BAR -->.*?</header>', '<div id="global-header"></div>')
    
    # 2. Replace Footer
    $content = [regex]::Replace($content, '(?s)<!-- FOOTER -->.*?</footer>', '<div id="global-footer"></div>')
    
    # 3. Strip old newsletter
    $content = [regex]::Replace($content, '(?s)<!-- NEWSLETTER MODAL -->.*?</div>\s*</div>', '')
    
    # 4. Inject scripts
    if ($content -notmatch '<script src="components.js"') {
        $content = $content.Replace('<script src="main.js" defer></script>', '<script src="components.js"></script>
  <script src="main.js" defer></script>')
    }
    
    # 5. Subpage specific logic
    if ($f.Name -ne 'index.html') {
        # Hashtags setup
        if ($content -notmatch '<div id="global-hashtags"></div>') {
            $content = $content.Replace('<div id="global-footer"></div>', '<div id="global-hashtags"></div>
  <div id="global-footer"></div>')
        }
        
        # Grid substitution (Adaptive Grid for Subpage)
        $content = [regex]::Replace($content, '(?s)<div class="subpage-content.*?</div>\s*</div>\s*</section>', $newGrid)
    }

    # 6. WA Accessibility: Add missing ALTs to IMGs
    $content = [regex]::Replace($content, '(?i)<img(?![^>]*alt=)[^>]*>', {
        param($m)
        $m.Value.Replace('<img', '<img alt="자동 할당 웹 대체 텍스트"')
    })

    [System.IO.File]::WriteAllText($f.FullName, $content, [System.Text.Encoding]::UTF8)
    $count++
}

Write-Output "PowerShell Script processed $count HTML files successfully."
