# 添加如下内容：
clear
# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
# 引入starship
Invoke-Expression (&starship init powershell)
Import-Module Terminal-Icons
Import-Module posh-git


# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# Fzf
# install :Install-Module -Name PSFzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# # Env
# $env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"



# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}


# Alias
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias vim nvim
#Set-Alias nvim neovide

#代理
function proxy {
    $env:http_proxy = "http://127.0.0.1:7890"
    $env:https_proxy = "http://127.0.0.1:7890"
    [System.Net.WebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy("http://127.0.0.1:7890")
    Write-Host "Proxy enabled: http://127.0.0.1:7890" -ForegroundColor Green
}

function unproxy {
    $env:http_proxy = $null
    $env:https_proxy = $null
    [System.Net.WebRequest]::DefaultWebProxy = $null
    Write-Host "Proxy disabled" -ForegroundColor Yellow
}

function check-proxy {
    if ($env:http_proxy -or $env:https_proxy) {
        Write-Host "Current proxy settings:" -ForegroundColor Cyan
        Write-Host "HTTP Proxy: $env:http_proxy"
        Write-Host "HTTPS Proxy: $env:https_proxy"
    } else {
        Write-Host "No proxy is currently set." -ForegroundColor Cyan
    }
}