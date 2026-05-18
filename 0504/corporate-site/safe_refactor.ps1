$ErrorActionPreference = "Continue"
$path = "c:\Users\4-410\Desktop\0504\corporate-site"
$files = Get-ChildItem -Path $path -Filter "*.html"

$newGrid = @"
<div class="subpage-content adaptive-grid fade-up-element">
  <div class="grid-text-area">
    <h2>제품 및 서비스 상세 정보</h2>
    <p>본 페이지는 첨단 AI 비전 및 로봇 모듈 라인업을 보여주는 영역입니다. 글로벌 표준 기구 인증을 통과한 파트들의 역량을 직관적인 그래픽과 함께 확인하십시오. 가상환경 레이아웃이 적용되었습니다.</p>
  </div>
  <div class="grid-media-area">
    <div class="media-placeholder focusable" tabindex="0">
      <span class="play-icon">▶</span>
      <p>3D 로봇 인포그래픽 / 비디오 영역</p>
    </div>
  </div>
</div>
"@

$count = 0
foreach ($f in $files) {
    # .alyac 백업본이 있으면 거기서 원본 복원 (글자 깨짐 방지)
    $backupFile = $f.FullName + ".alyac"
    if (Test-Path $backupFile) {
        Copy-Item -Path $backupFile -Destination $f.FullName -Force
    }

    # 기본 UTF8 읽기
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    
    # 1. Header Replace (안전한 IndexOf 방식)
    $startH = $content.IndexOf("<!-- TOP BAR -->")
    $endH = $content.IndexOf("</header>")
    if ($startH -ge 0 -and $endH -gt $startH) {
        $length = ($endH + 9) - $startH
        $content = $content.Remove($startH, $length).Insert($startH, '<div id="global-header"></div>')
    }

    # 2. Footer Replace
    $startF = $content.IndexOf("<!-- FOOTER -->")
    $endF = $content.IndexOf("</footer>")
    if ($startF -ge 0 -and $endF -gt $startF) {
        $length = ($endF + 9) - $startF
        $content = $content.Remove($startF, $length).Insert($startF, '<div id="global-footer"></div>')
    }

    # 3. Scripts injection
    if ($content.IndexOf('<script src="components.js"') -eq -1) {
        $content = $content.Replace('<script src="main.js" defer></script>', '<script src="components.js"></script>`r`n  <script src="main.js" defer></script>')
    }

    # 4. Subpage Logic (빈 페이지 문제 방지 및 Hashtag 연동)
    if ($f.Name -ne 'index.html') {
        if ($content.IndexOf('<div id="global-hashtags"></div>') -eq -1) {
            $content = $content.Replace('<div id="global-footer"></div>', '<div id="global-hashtags"></div>`r`n  <div id="global-footer"></div>')
        }
        
        # 안전한 서브페이지 콘텐츠 교체
        $startS = $content.IndexOf('<div class="subpage-content')
        if ($startS -ge 0) {
            $endS = $content.IndexOf('</div>', $content.IndexOf('</div>', $startS) + 5) # 간단하게 2번째 </div> 위치 근사치
            if ($endS -gt $startS) {
                # 정규식 대신 Content를 뭉텅 잘라내고 Grid 삽입
                $content = [regex]::Replace($content, '(?s)<div class="subpage-content.*?</div>\s*</div>', $newGrid)
            }
        } else {
            # 아예 비어있는 경우 새로 삽입
            $content = $content.Replace('</section>', $newGrid + "`r`n</section>")
        }
    }

    # 5. ALT 태그 (간단 리플레이스)
    $content = $content.Replace('<img src="images/hero2.png" alt="Arm Mod">', '<img src="images/hero2.png" alt="Arm Mod">') # 더미 방어

    [System.IO.File]::WriteAllText($f.FullName, $content, [System.Text.Encoding]::UTF8)
    $count++
}

Write-Output "Safe Script Complete: $count Files processed."
