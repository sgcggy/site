$path = "c:\Users\4-410\Desktop\0504\corporate-site"

# 1. 파일 복구 (글자 깨짐 및 내용 상실 원상 복원)
Get-ChildItem -Path $path -Filter "*.html.alyac" | ForEach-Object {
    $orig = $_.FullName.Replace(".alyac", "")
    Copy-Item $_.FullName $orig -Force
}

# 2. 안전한 일괄 치환
$files = Get-ChildItem -Path $path -Filter "*.html"
foreach ($f in $files) {
    if ($f.Name -match "\.alyac$") { continue }
    
    # UTF8 인코딩을 명시하여 글자 깨짐 방지
    $txt = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    
    # 헤더/푸터 컴포넌트화
    $txt = $txt -replace '(?s)<!-- TOP BAR -->.*?</header>', '<div id="global-header"></div>'
    $txt = $txt -replace '(?s)<!-- FOOTER -->.*?</footer>', '<div id="global-footer"></div>'
    $txt = $txt -replace '(?s)<!-- NEWSLETTER MODAL -->.*?</div>\s*</div>', ''
    
    # js 모듈화
    if (-not $txt.Contains('<script src="components.js"')) {
        $txt = $txt.Replace('<script src="main.js" defer></script>', '<script src="components.js"></script><script src="main.js" defer></script>')
    }
    
    # 서브페이지 전처리 (Adaptive Grid)
    if ($f.Name -ne 'index.html') {
        if (-not $txt.Contains('<div id="global-hashtags"></div>')) {
            $txt = $txt.Replace('<div id="global-footer"></div>', '<div id="global-hashtags"></div><div id="global-footer"></div>')
        }
        $grid = '<div class="subpage-content adaptive-grid fade-up-element"><div class="grid-text-area"><h2>첨단 비전 및 제품 정보</h2><p>이 페이지는 SGC의 첨단 부품 및 파이프라인 정보를 다이내믹 3D 프레임으로 제공합니다. 글로벌 인프라 검증을 통과한 파트들의 퀄리티를 확인하세요.</p></div><div class="grid-media-area"><div class="media-placeholder focusable" tabindex="0"><span class="play-icon">▶</span><p>3D 인포그래픽 미디어 뷰어</p></div></div></div>'
        $txt = $txt -replace '(?s)<div class="subpage-content[^>]*>.*?</div>\s*</div>', $grid
    }
    
    [System.IO.File]::WriteAllText($f.FullName, $txt, [System.Text.Encoding]::UTF8)
}
Write-Output "Fix script fully executed without Syntax Errors."
