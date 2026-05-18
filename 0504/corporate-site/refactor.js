const fs = require('fs');
const path = require('path');

const dirPath = 'c:\\Users\\4-410\\Desktop\\0504\\corporate-site';

const headerRegex = /<!-- TOP BAR -->[\s\S]*?<\/header>/;
const footerRegex = /<!-- FOOTER -->[\s\S]*?<\/footer>/;
const newsletterRegex = /<!-- NEWSLETTER MODAL -->[\s\S]*?<\/div>\s*<\/div>/;
const subpageRegex = /<div class="subpage-content[^>]*">[\s\S]*?<\/div>\s*<\/div>\s*<\/section>/;

const newSubpageContent = `
<div class="subpage-content adaptive-grid fade-up-element">
  <div class="grid-text-area">
    <h2>제품 및 서비스 상세 정보</h2>
    <p>본 페이지는 첨단 AI 비전 및 로봇 모듈 라인업을 보여주는 영역입니다. 글로벌 표준 기구 인증을 통과한 파트들의 역량을 다이내믹한 3D 그래픽과 함께 확인하십시오. 가상환경 레이아웃이 적용되었습니다.</p>
  </div>
  <div class="grid-media-area">
    <div class="media-placeholder focusable" tabindex="0">
      <span class="play-icon">▶</span>
      <p>3D 로봇 모듈 인포그래픽 / 비디오 영역</p>
    </div>
  </div>
</div>
</div>
</section>
`;

let modifiedCount = 0;

fs.readdirSync(dirPath).forEach(file => {
  if (file.endsWith('.html')) {
    const filePath = path.join(dirPath, file);
    let content = fs.readFileSync(filePath, 'utf-8');

    content = content.replace(headerRegex, '<div id="global-header"></div>');
    content = content.replace(footerRegex, '<div id="global-footer"></div>');
    content = content.replace(newsletterRegex, '');

    if (!content.includes('<script src="components.js"')) {
      content = content.replace('<script src="main.js" defer></script>', '<script src="components.js"></script>\n  <script src="main.js" defer></script>');
    }

    if (file !== 'index.html' && !content.includes('<div id="global-hashtags"></div>')) {
      content = content.replace('<div id="global-footer"></div>', '<div id="global-hashtags"></div>\n  <div id="global-footer"></div>');
    }

    if (file !== 'index.html') {
      content = content.replace(subpageRegex, newSubpageContent);
    }

    // WA: Add missing alt tags
    content = content.replace(/<img\s+(?!.*alt=)[^>]*>/g, match => match.replace('<img', '<img alt="자동 할당 로봇 시각 자료"'));

    fs.writeFileSync(filePath, content, 'utf-8');
    modifiedCount++;
  }
});
console.log(`Node refactor complete for ${modifiedCount} files.`);
