$ErrorActionPreference = "Continue"

try {
    $url = "https://sgcggy-site.vercel.app/support.html"
    $response = Invoke-WebRequest -Uri $url -UseBasicParsing
    [System.IO.File]::WriteAllText("c:\Users\4-410\Desktop\0504\corporate-site\scraped_support.html", $response.Content, [System.Text.Encoding]::UTF8)
} catch {
    Write-Output "support.html not found, fetching root."
}

try {
    $url2 = "https://sgcggy-site.vercel.app/"
    $response2 = Invoke-WebRequest -Uri $url2 -UseBasicParsing
    [System.IO.File]::WriteAllText("c:\Users\4-410\Desktop\0504\corporate-site\scraped_index.html", $response2.Content, [System.Text.Encoding]::UTF8)
} catch {
    Write-Output "root not found either."
}

Write-Output "Scrape complete."
