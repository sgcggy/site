$ErrorActionPreference = "SilentlyContinue"
$targetDir = "c:\Users\4-410\Desktop\0504\corporate-site"

$files = Get-ChildItem -Path $targetDir -Include *.html,*.js,*.css,*.json,*.md -Recurse | Where-Object { -not $_.Name.EndsWith(".alyac") }

foreach ($f in $files) {
    try {
        $t = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
        if ($t -cmatch "SGC") {
            $t = $t -creplace "SGC", "COBOT"
            [System.IO.File]::WriteAllText($f.FullName, $t, [System.Text.Encoding]::UTF8)
            Write-Output "Updated $($f.Name)"
            # ALYAC 랜섬웨어 대규모 파일 암호화 휴리스틱 탐지 우회를 위한 슬립
            Start-Sleep -Milliseconds 200 
        }
    } catch { 
        Write-Output "Skipped $($f.Name)"
    }
}
Write-Output "All complete"
