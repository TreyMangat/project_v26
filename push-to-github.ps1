# Run this AFTER logging in with: gh auth login
# Creates the GitHub repo "valentines" and pushes your code

$ErrorActionPreference = "Stop"
$repoName = "valentines"

# Refresh PATH so gh and git are found
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Set-Location $PSScriptRoot

Write-Host "Checking GitHub login..." -ForegroundColor Cyan
gh auth status
if ($LASTEXITCODE -ne 0) {
    Write-Host "`nPlease run:  gh auth login" -ForegroundColor Yellow
    Write-Host "Complete the browser login, then run this script again.`n" -ForegroundColor Yellow
    exit 1
}

Write-Host "`nCreating repo '$repoName' on GitHub and pushing..." -ForegroundColor Cyan
gh repo create $repoName --public --source=. --remote=origin --push

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nDone! Your repo is at: https://github.com/$(gh api user -q .login)/$repoName" -ForegroundColor Green
} else {
    Write-Host "`nIf the repo already exists, just run: git push -u origin main" -ForegroundColor Yellow
}
