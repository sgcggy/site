const headerHTML = `
  <div class="top-bar">
    <div class="container top-bar-content">
      <div class="top-bar-left"></div>
      <div class="top-bar-right">
        <a href="#contact" class="top-contact" tabindex="0">🎧 B2B 파트너십 문의</a>
        <div class="lang-selector">
          <select aria-label="언어 선택" tabindex="0">
            <option value="ko">KOR</option>
            <option value="en">ENG</option>
          </select>
        </div>
        <button id="open-search-btn" aria-label="검색 오버레이 열기" tabindex="0">🔍 검색</button>
      </div>
    </div>
  </div>
  <header class="header">
    <div class="container header-container">
      <div class="logo">
        <a href="index.html" class="logo-link" tabindex="0">
          COBOT <span class="neon-text">SOLUTIONS</span>
        </a>
      </div>
      <nav class="gnb" aria-label="메인 네비게이션">
        <ul role="menubar">
          <li role="none" class="has-mega-menu">
            <a role="menuitem" href="intro.html" tabindex="0">기업정보</a>
            <div class="mega-menu">
               <div class="mega-content container">
                 <div class="mega-links">
                   <div class="mega-col"><h4>기업 소개</h4><ul>
                     <li><a href="intro.html" tabindex="0">COBOT 소개</a></li>
                     <li><a href="ceo.html" tabindex="0">CEO 인사말</a></li>
                     <li><a href="vision.html" tabindex="0">미션 및 비전</a></li>
                     <li><a href="history.html" tabindex="0">연혁</a></li>
                   </ul></div>
                   <div class="mega-col"><h4>IR</h4><ul>
                     <li><a href="ir.html" tabindex="0">B2B 실적발표</a></li>
                     <li><a href="stock.html" tabindex="0">주가정보</a></li>
                   </ul></div>
                   <div class="mega-col"><h4>지배구조</h4><ul>
                     <li><a href="disclosure.html" tabindex="0">공시/공고</a></li>
                   </ul></div>
                 </div>
               </div>
            </div>
          </li>
          <li role="none" class="has-mega-menu">
            <a role="menuitem" href="sus.html" tabindex="0">지속가능경영</a>
            <div class="mega-menu">
               <div class="mega-content container">
                 <div class="mega-links">
                   <div class="mega-col"><h4>Planet</h4><ul>
                     <li><a href="env.html" tabindex="0">환경전략</a></li>
                     <li><a href="climate.html" tabindex="0">기후변화</a></li>
                   </ul></div>
                   <div class="mega-col"><h4>People</h4><ul>
                     <li><a href="employee.html" tabindex="0">산업 안전</a></li>
                     <li><a href="social.html" tabindex="0">사회공헌</a></li>
                   </ul></div>
                 </div>
               </div>
            </div>
          </li>
          <li role="none" class="has-mega-menu">
            <a role="menuitem" href="products.html" tabindex="0">제품정보</a>
            <div class="mega-menu">
               <div class="mega-content container">
                 <div class="mega-links">
                   <div class="mega-col"><h4>로봇 카테고리 (분류)</h4><ul>
                     <li><a href="products_arm.html" tabindex="0">로봇 암 (산업/협동)</a></li>
                     <li><a href="products_quad.html" tabindex="0">사족보행 로봇 (순찰/수송)</a></li>
                     <li><a href="products_amr.html" tabindex="0">이동형 로봇 (AMR/물류)</a></li>
                   </ul></div>
                   <div class="mega-col"><h4>초격차 인증</h4><ul>
                     <li><a href="products.html" tabindex="0">COBOT 로봇 품질(QC) 아키텍처</a></li>
                   </ul></div>
                 </div>
               </div>
            </div>
          </li>
          <li role="none"><a role="menuitem" href="support.html" tabindex="0">고객지원</a></li>
        </ul>
      </nav>
    </div>
  </header>
`;

const searchOverlayHTML = `
  <div id="search-overlay" class="search-overlay hidden" aria-hidden="true">
    <div class="search-overlay-close-wrap">
      <button id="close-search-btn" aria-label="검색 닫기" tabindex="0">✖</button>
    </div>
    <div class="search-content">
      <h2>무엇을 찾으시나요?</h2>
      <div class="search-input-box">
        <input type="text" placeholder="검색어를 입력하세요..." aria-label="검색어 입력" tabindex="0">
        <button aria-label="검색 실행" tabindex="0">🔍</button>
      </div>
      <div class="search-quick-links">
        <h3>자주 찾는 검색어</h3>
        <div class="quick-cards">
          <a href="#" class="quick-card" tabindex="0">📝 ISO 15066 안전 인증서</a>
          <a href="#" class="quick-card" tabindex="0">⚙️ 모듈 Part Number 조회</a>
          <a href="#" class="quick-card" tabindex="0">📊 최신 IR 실적 자료</a>
        </div>
      </div>
    </div>
  </div>
`;

const dashlinkHTML = `
  <div id="dashlink-widget" class="dashlink-widget">
    <button id="dashlink-toggle" class="dashlink-toggle" aria-label="대시링크 열기 닫기" tabindex="0">📊 Dashlink</button>
    <div id="dashlink-panel" class="dashlink-panel hidden" aria-hidden="true">
      <div class="dashlink-header">
        <h4>라이브 대시보드</h4>
      </div>
      <div class="dashlink-body">
        <div class="dash-section">
          <h5>📈 COBOT 주가</h5>
          <p class="stock-price">₩ 84,500 <span class="up">▲ 1.2%</span></p>
        </div>
        <div class="dash-section">
          <h5>🏭 로봇 생산 현황</h5>
          <p>금일 출하 대기: <strong>1,420 Unit</strong></p>
          <div class="progress-bar"><div class="progress" style="width: 78%;"></div></div>
        </div>
        <div class="dash-section">
          <h5>최신 IR 뉴스</h5>
          <ul>
            <li><a href="news.html" tabindex="0">AI 비전 모듈 신규 탑재 발표</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
`;

const footerHTML = `
  <footer class="footer">
    <div class="container footer-top">
      <div class="footer-links">
        <a href="#support" tabindex="0">파트너십 제휴</a>
        <a href="#security" tabindex="0">윤리경영 및 품질 신뢰</a>
      </div>
    </div>
    <div class="container footer-bottom">
      <p class="copyright">© 2026 Cobot Solutions. High-Tech Enterprise Theme.</p>
    </div>
  </footer>
`;

const hashtagsHTML = `
  <section class="hashtag-section container fade-up-element">
    <div class="hashtag-wrap">
      <h3>연관 키워드 탐색</h3>
      <div class="tags">
        <a href="products.html" tabindex="0">#로봇부품</a>
        <a href="products.html" tabindex="0">#스마트팩토리</a>
        <a href="intro.html" tabindex="0">#AI비전모듈</a>
        <a href="sus.html" tabindex="0">#지속가능경영</a>
        <a href="eco.html" tabindex="0">#ESG</a>
      </div>
    </div>
  </section>
`;

document.addEventListener('DOMContentLoaded', () => {
  const headerContainer = document.getElementById('global-header');
  if (headerContainer) headerContainer.innerHTML = headerHTML;
  
  const footerContainer = document.getElementById('global-footer');
  if (footerContainer) footerContainer.innerHTML = footerHTML;

  const hashtagsContainer = document.getElementById('global-hashtags');
  if (hashtagsContainer) hashtagsContainer.innerHTML = hashtagsHTML;

  document.body.insertAdjacentHTML('beforeend', searchOverlayHTML);
  document.body.insertAdjacentHTML('beforeend', dashlinkHTML);

  // 1초 이내 즉각적인 접속(초스피드 렌더링)을 위해 딜레이를 50ms로 대폭 단축 (최소한의 Layout Shift 억제)
  setTimeout(() => {
    document.body.classList.add('page-loaded');
  }, 50);
});
