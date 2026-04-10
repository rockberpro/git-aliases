$ErrorActionPreference = "Stop"

$GitconfigUrl = "https://raw.githubusercontent.com/rockberpro/git-lga/main/git-lga.gitconfig"
$InstallPath = "$HOME\.git-lga.gitconfig"

$HelpUrl = "https://raw.githubusercontent.com/rockberpro/git-lga/main/git-lga-help.sh"
$HelpPath = "$HOME\.git-lga-help.sh"

Invoke-WebRequest -Uri $GitconfigUrl -OutFile $InstallPath -UseBasicParsing

$includes = git config --global --get-all include.path 2>$null
if ($includes -notcontains $InstallPath) {
    git config --global --add include.path $InstallPath
}

Invoke-WebRequest -Uri $HelpUrl -OutFile $HelpPath -UseBasicParsing

Write-Host "git-lga installed: $InstallPath"
Write-Host "git-lga help installed: $HelpPath"
