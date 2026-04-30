$ErrorActionPreference = "Stop"

$GitconfigUrl = "https://raw.githubusercontent.com/rockberpro/git-lga/main/git-lga.gitconfig"
$InstallPath = "$HOME\.git-lga.gitconfig"

$HelpUrl = "https://raw.githubusercontent.com/rockberpro/git-lga/main/git-lga-help.sh"
$HelpPath = "$HOME\.git-lga-help.sh"

$Ps1Url = "https://raw.githubusercontent.com/rockberpro/git-lga/main/git-lga.ps1"
$Ps1Path = "$HOME\.git-lga.ps1"

Invoke-WebRequest -Uri $GitconfigUrl -OutFile $InstallPath -UseBasicParsing

$includes = git config --global --get-all include.path 2>$null
if ($includes -notcontains $InstallPath) {
    git config --global --add include.path $InstallPath
}

Invoke-WebRequest -Uri $HelpUrl -OutFile $HelpPath -UseBasicParsing

Invoke-WebRequest -Uri $Ps1Url -OutFile $Ps1Path -UseBasicParsing

if (!(Test-Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}

$sourceLine = ". `"$Ps1Path`""
if (!(Select-String -Path $PROFILE -SimpleMatch $Ps1Path -Quiet)) {
    Add-Content -Path $PROFILE -Value $sourceLine
}

Write-Host "git-lga installed: $InstallPath"
Write-Host "git-lga help installed: $HelpPath"
Write-Host "git-lga ps1 installed: $Ps1Path"
