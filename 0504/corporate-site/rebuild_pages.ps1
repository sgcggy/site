$path = "c:\Users\4-410\Desktop\0504\corporate-site"
$files = Get-ChildItem -Path $path -Filter "*.html" | Where-Object { $_.Name -ne 'index.html' -and $_.Name -notmatch '\.alyac$' }

$subpageTemplate = @"
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>SGC Corporate Subpage</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="style.css">
  <link rel="stylesheet" href="subpage.css">
</head>
<body>
  <div id="global-header"></div>
  <main>
    <div class="page-header">
       <div class="container">
         <h1>High-Tech Solutions</h1>
         <div class="breadcrumb">경로: <a href="index.html">홈</a> > <span>상세 기술 스펙</span></div>
       </div>
    </div>
    <section class="subpage-section">
      <div class="container">
        <div class="subpage-content adaptive-grid fade-up-element">
          <div class="grid-text-area">
            <h2>첨단 비전 및 제품 정보</h2>
            <p>이 페이지는 SGC의 첨단 부품 및 파이프라인 정보를 3D 다이내믹 뷰로 제공합니다. 글로벌 인프라 검증을 통과한 고정밀 제어 모듈과 환경 시스템을 인포그래픽으로 탐색하십시오.</p>
          </div>
          <div class="grid-media-area">
            <div class="media-placeholder focusable" tabindex="0">
              <span class="play-icon">▶</span>
              <p>3D 로봇 부품 / 비전 AI 인포그래픽 뷰어</p>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
  <div id="global-hashtags"></div>
  <div id="global-footer"></div>
  
  <script src="components.js"></script>
  <script src="main.js" defer></script>
</body>
</html>
"@

foreach ($f in $files) {
    [System.IO.File]::WriteAllText($f.FullName, $subpageTemplate, [System.Text.Encoding]::UTF8)
}

$indexTemplate = @"
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cobot Solutions - The Precision Behind Global Cobots</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div id="global-header"></div>
  
  <main>
    <section class="hero-carousel">
      <div class="carousel-track" id="hero-track">
        <div class="carousel-slide" style="background-image: url('images/cobot_hero.png')">
           <div class="hero-overlay"></div>
           <div class="container hero-content">
             <h1 class="hero-title">The Precision Behind Global Cobots</h1>
             <p class="hero-subtitle">전장 및 AI 비전 모듈이 탑재된 하이엔드 로보틱스 솔루션</p>
             <button class="btn btn-outline play-video-btn"><span class="icon-play">▶</span> 협력 문의하기</button>
           </div>
        </div>
        <div class="carousel-slide" style="background-image: url('images/hero2.png')">
           <div class="hero-overlay"></div>
           <div class="container hero-content">
             <h1 class="hero-title">High-Tech Vision Integration</h1>
             <p class="hero-subtitle">가장 진보한 객체 인식 및 자동화 라인 동기화 캘리브레이션</p>
             <button class="btn btn-primary">솔루션 자세히 보기</button>
           </div>
        </div>
      </div>
      <div class="carousel-indicators" id="carousel-indicators"></div>
    </section>

    <section class="stats-section" id="corp">
      <div class="container">
        <div class="stats-grid">
          <div class="stat-item fade-up-element">
            <div class="stat-icon">⚙️</div>
            <h3 class="stat-value" data-target="15000">15000</h3>
            <p class="stat-label">초정밀 모션 제어 생산</p>
          </div>
          <div class="stat-item highlight fade-up-element">
            <div class="stat-icon">🌐</div>
            <h3 class="stat-value">Target OEM</h3>
            <p class="stat-label">UR, Doosan 등 글로벌 파트너</p>
          </div>
          <div class="stat-item fade-up-element">
            <div class="stat-icon">👁️</div>
            <h3 class="stat-value">Vision AI</h3>
            <p class="stat-label">지능형 객체 감지 시스템</p>
          </div>
          <div class="stat-item fade-up-element">
            <div class="stat-icon">🛡️</div>
            <h3 class="stat-value">ISO 15066</h3>
            <p class="stat-label">다중 토크 센서 안전 라인</p>
          </div>
        </div>
      </div>
    </section>
  </main>
  
  <div id="global-footer"></div>
  
  <script src="components.js"></script>
  <script src="main.js" defer></script>
</body>
</html>
"@

[System.IO.File]::WriteAllText("$path\index.html", $indexTemplate, [System.Text.Encoding]::UTF8)

Write-Output "Successfully rebuilt all layout files with UTF-8 Component structures."
