function Get-ExtensionTitle {
    param(
        [string]$extensionId
    )

    $url = "https://chrome.google.com/webstore/detail/" + $extensionId

    try {
        $webClient = New-Object System.Net.WebClient
        $response = $webClient.DownloadString($url)

        $titleStartIndex = $response.IndexOf("<title>")
        $titleEndIndex = $response.IndexOf("</title>")
        $title = $response.Substring($titleStartIndex + 7, $titleEndIndex - $titleStartIndex - 7)

        # Definir a codificação para UTF-8
        [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

        Write-Host ("Título da extensão " + $extensionId + ": " + $title)
    } catch {
        Write-Host ("Erro ao acessar a URL da extensão " + $extensionId + ": " + $_)
    }
}

# Ler os IDs das extensões a partir do arquivo
$lista_extensoes = Get-Content -Path "ids_extensoes.txt"

foreach ($extensaoId in $lista_extensoes) {
    Get-ExtensionTitle -extensionId $extensaoId
}
