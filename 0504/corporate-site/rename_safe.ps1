$ErrorActionPreference = "Stop"
$targetDir = "c:\Users\4-410\Desktop\0504\corporate-site"
$extensions = @("*.html", "*.js", "*.css", "*.json", "*.md", "*.txt")

foreach ($ext in $extensions) {
    $files = Get-ChildItem -Path $targetDir -Filter $ext -File
    foreach ($file in $files) {
        try {
            $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
            if ($content -cmatch "SGC") {
                $content = $content -creplace "SGC", "COBOT"
                [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
                Write-Output "Updated $($file.Name)"
            }
        } catch {
            Write-Output "Skipped $($file.Name) due to lock or error"
        }
    }
}
Write-Output "Done"
