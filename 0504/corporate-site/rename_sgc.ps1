$ErrorActionPreference = "Continue"

$targetDir = "c:\Users\4-410\Desktop\0504\corporate-site"
$extensions = @("*.html", "*.js", "*.css", "*.json", "*.md")

foreach ($ext in $extensions) {
    $files = Get-ChildItem -Path $targetDir -Filter $ext -File
    foreach ($file in $files) {
        $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        
        # -clike / -creplace : 대소문자를 엄격히 구분하여 'SGC' 문자열만 타겟팅 (sgc_이미지명 보호)
        if ($content -cmatch "SGC") {
            $content = $content -creplace "SGC", "COBOT"
            [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
            Write-Output "Updated $($file.Name)"
        }
    }
}
Write-Output "Replacement (SGC -> COBOT) complete."
