$ErrorActionPreference = "Continue"

$jsonText = [System.IO.File]::ReadAllText("c:\Users\4-410\Desktop\0504\corporate-site\routes.json", [System.Text.Encoding]::UTF8)
$dict = $jsonText | ConvertFrom-Json

$path = "c:\Users\4-410\Desktop\0504\corporate-site"
$templatePath = "c:\Users\4-410\Desktop\0504\corporate-site\template_subpage.html"

foreach ($prop in $dict.psobject.properties) {
    $file = $prop.Name
    $data = $prop.Value
    
    $title = $data[0]
    $section = $data[1]
    $desc = $data[2]
    
    $txt = [System.IO.File]::ReadAllText($templatePath, [System.Text.Encoding]::UTF8)
    
    $txt = $txt.Replace("High-Tech Solutions", $title)
    $txt = $txt.Replace("상세 내용", $title)
    $txt = $txt.Replace("첨단 비전 및 제품 정보", $section)
    $txt = $txt.Replace("이 페이지는 SGC의 기술 인프라를 소개합니다. 좌측 메뉴나 상단의 항목을 통해 들어오셨습니다.", $desc)
    
    $targetPath = Join-Path $path $file
    [System.IO.File]::WriteAllText($targetPath, $txt, [System.Text.Encoding]::UTF8)
}

Write-Output "Successfully compiled ALL HTML routes safely using JSON."
