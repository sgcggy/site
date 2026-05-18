$path = "c:\Users\4-410\Desktop\0504\corporate-site"
$subpage = Join-Path $path "template_subpage.html"
$index = Join-Path $path "template_index.html"

$files = Get-ChildItem -Path $path -Filter "*.html" | Where-Object { 
  $_.Name -ne "template_subpage.html" -and $_.Name -ne "template_index.html" -and $_.Name -notmatch '\.alyac$'
}

foreach ($f in $files) {
    if ($f.Name -eq "index.html") {
        Copy-Item $index $f.FullName -Force
    } else {
        Copy-Item $subpage $f.FullName -Force
    }
}
Write-Output "Copied all templates perfectly without touching PS1 file encoding."
