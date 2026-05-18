import os
import re

dir_path = r'c:\Users\4-410\Desktop\0504\corporate-site'

header_regex = re.compile(r'<!-- TOP BAR -->.*?</header>', re.DOTALL)
footer_regex = re.compile(r'<!-- FOOTER -->.*?</footer>', re.DOTALL)
newsletter_regex = re.compile(r'<!-- NEWSLETTER MODAL -->.*?</div>\s*</div>', re.DOTALL)

subpage_regex = re.compile(r'<div class="subpage-content(?:[^>]*)">.*?</div>\s*</div>\s*</section>', re.DOTALL)
new_subpage = """<div class="subpage-content adaptive-grid fade-up-element">
  <div class="grid-text-area">
    <h2>제품 및 서비스 상세 정보</h2>
    <p>본 페이지는 첨단 AI 비전 및 로봇 모듈 라인업을 보여주는 영역입니다. 글로벌 표준 기구 인증을 통과한 SGC 파트들의 역량을 직관적인 그래픽과 함께 확인하십시오. 고도화된 그리드 디자인에 기반합니다.</p>
  </div>
  <div class="grid-media-area">
    <div class="media-placeholder focusable" tabindex="0">
      <span class="play-icon">▶</span>
      <p>3D 로봇 인포그래픽 / 비디오 썸네일 영역</p>
    </div>
  </div>
</div>
</div>
</section>"""

for filename in os.listdir(dir_path):
    if filename.endswith('.html'):
        filepath = os.path.join(dir_path, filename)
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Replace header
        if header_regex.search(content):
            content = header_regex.sub('<div id="global-header"></div>', content)
        
        # Replace footer
        if footer_regex.search(content):
            content = footer_regex.sub('<div id="global-footer"></div>', content)
            
        content = newsletter_regex.sub('', content)

        # Inject components.js
        if '<script src="components.js"' not in content:
            content = content.replace('<script src="main.js" defer></script>',
                                      '<script src="components.js" defer></script>\n  <script src="main.js" defer></script>')

        # Hash tag section for subpages
        if filename != 'index.html' and '<div id="global-hashtags"></div>' not in content:
            content = content.replace('<div id="global-footer"></div>', '<div id="global-hashtags"></div>\n  <div id="global-footer"></div>')

        # Replace single text body with adaptive grid (Phase 3)
        if filename != 'index.html':
            if subpage_regex.search(content):
                content = subpage_regex.sub(new_subpage, content)

        # Web Accessibility: Add alt to images missing it
        content = re.sub(r'<img\s+(?!.*alt=)[^>]*>', lambda m: m.group(0).replace('<img', '<img alt="자동 할당된 기업 로봇 시각 자료"'), content)

        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)

print("Mass refactoring script complete.")
