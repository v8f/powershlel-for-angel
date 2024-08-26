$installPath = "C:\Program Files\7-Zip"
$installerPath = "$env:TEMP\7zip_installer.msi"
if ([Environment]::Is64BitOperatingSystem) {
    $url = "https://www.7-zip.org/a/7z2408-x64.msi"
} else {
    $url = "https://www.7-zip.org/a/7z2408.msi"
}
Invoke-WebRequest -Uri $url -OutFile $installerPath
Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" /qn" -Wait
Remove-Item $installerPath
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
if (-not $currentPath.Contains($installPath)) {
    $newPath = $currentPath + ";" + $installPath
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")
}
Write-Host "7-Zip has been installed and added to the system PATH."
