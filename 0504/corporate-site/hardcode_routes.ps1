$ErrorActionPreference = "Continue"

$dict = @{
    'intro.html' = @('기업정보', 'SGC 기업 소개', 'SGC의 핵심 가치와 연혁, 그리고 글로벌 기술 인프라를 확인할 수 있는 페이지입니다. B2B 파트너십을 위한 근간이 됩니다.')
    'ceo.html' = @('CEO 인사말', '대표이사 인사말', '미래 로보틱스와 AI 중심의 디지털 전환을 이끌어가는 SGC 리더의 포부 및 고객에게 전하는 메시지입니다.')
    'vision.html' = @('미션 및 비전', '글로벌 핵심 비전', '초정밀 모션 제어 및 안전 솔루션을 기반으로 한 SGC의 차세대 비전 로드맵을 선언합니다.')
    'history.html' = @('기업 연혁', '도전의 역사', '1974년 창립 이후 최첨단 팩토리 자동화 시스템 기업으로 성장해 온 발자취와 인증 내역을 안내합니다.')
    'sus.html' = @('지속가능경영', 'ESG 경영 철학', '지구 환경과 인류의 미래를 생각하는 SGC의 투명한 지배구조 및 친환경 로보틱스 양산 전략입니다.')
    'eco.html' = @('환경전략', '친환경 인프라', '탄소 중립(Carbon Neutrality) 실현을 위한 재생에너지 사용 및 플라스틱 저감 설계 공정을 소개합니다.')
    'products.html' = @('제품정보', '로보틱스 라인업', '1kHz 단위 추적이 가능한 H/W 토크 센서와 비전 AI 모듈 등 다양한 주력 파트의 제원을 탐색하십시오.')
    'career.html' = @('인재채용', 'SGC 피플', '자율주행, 제어 알고리즘, 스마트 팩토리 등 최고 수준의 미래를 설계할 엔지니어를 기다립니다.')
    'news.html' = @('뉴스룸', '최신 보도자료', 'SGC의 혁신적인 기술 개발 성과, 파트너십 제휴, 그리고 기업 공지사항을 가장 빠르게 전달해 드립니다.')
    'support.html' = @('고객지원', '글로벌 파트너 지원', 'OEM 납품 및 시스템 구축 관련 FAQ, ISO 인증 자료, 기술 지원 문의 사항을 남겨주십시오.')
    'climate.html' = @('기후변화', '기후변화 대응', '글로벌 기후 위기에 대응하는 탄소 감축 시나리오를 투명하게 공개합니다.')
    'disclosure.html' = @('공시/공고', '투명한 지배구조', '주주 및 투자자를 위한 투명도 높은 공시 일정을 안내합니다.')
    'ir.html' = @('B2B 실적발표', '안정적 재무구조', 'SGC의 분기별 실적과 재무 건전성 리포트 자료입니다.')
    'stock.html' = @('주가정보', '투자자 스펙트럼', '현행 SGC의 글로벌 주가 및 자본 시장 동향을 보여줍니다.')
    'employee.html'= @('산업 안전', '근로 환경 개선', '사업장 내 무재해 요건을 충족하기 위한 직원 복지 및 안전 매뉴얼을 다룹니다.')
    'social.html'= @('사회공헌', '상생하는 SGC', '지역 사회와 함께 상생하는 SGC의 캠페인 기록입니다.')
    'ethics.html'= @('윤리경영', '청렴 경영 체계', '부패방지 시스템과 글로벌 수준의 청렴 기업 운영 규정입니다.')
    'compliance.html'= @('준법경영', '컴플라이언스 준수', '국내외 관련 볍규를 철저히 이행하는 준법 감시 프로그램 정보입니다.')
    'env.html'= @('탄소경영', '친환경 인프라 구축', '재생에너지 사용 촉진 등 체계적인 환경경영 비전입니다.')
    'impact.html'= @('환경영향', '영향도 분석 관리', '제품 주기 전반에 걸친 환경 영향도를 사전 분석하고 지속적으로 감소시킵니다.')
    'supply.html'= @('공급망 관리', '지속가능한 원자재 수급', '동반성장을 이루는 책임 있는 SGC의 협력사 공급망 정책을 소개합니다.')
    'library.html'= @('안전 라이브러리', '안전 매뉴얼 다운로드', '파트너사에 제공되는 각종 승인 및 공식 규격 제원 라이브러리 목록입니다.')
}

$path = "c:\Users\4-410\Desktop\0504\corporate-site"
$files = Get-ChildItem -Path $path -Filter "*.html" | Where-Object { $_.Name -ne 'index.html' }

foreach ($f in $files) {
    if ($dict.ContainsKey($f.Name)) {
        $data = $dict[$f.Name]
        $title = $data[0]
        $section = $data[1]
        $desc = $data[2]
        
        $txt = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
        
        $txt = $txt -replace '<h1 id="dynamic-title">.*?</h1\s*>', "<h1 id=`"dynamic-title`">$title</h1>"
        $txt = $txt -replace '<span id="dynamic-breadcrumb">.*?</span\s*>', "<span id=`"dynamic-breadcrumb`">$title</span>"
        $txt = $txt -replace '<h2 id="dynamic-section"[^>]*>.*?</h2\s*>', "<h2 id=`"dynamic-section`" style=`"color: #fff; margin-bottom: 20px;`">$section</h2>"
        $txt = $txt -replace '<p id="dynamic-desc"[^>]*>.*?</p\s*>', "<p id=`"dynamic-desc`" style=`"color: var(--text-base); line-height: 1.8;`">$desc</p>"
        
        [System.IO.File]::WriteAllText($f.FullName, $txt, [System.Text.Encoding]::UTF8)
    }
}
Write-Output "Hardcoded specific routes into all HTML files successfully."
