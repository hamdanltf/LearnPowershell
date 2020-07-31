# Class DirToBackup
# {
#     [String]$path
#     DirToBackup([String]$path) {
#       $this.path = $path
#     }
# }
$defaultListOfExcluded = "D:\LearnPowershell\listOfExcluded.txt"
$pathFromPrefix = "D:\"
$pathToPrefix = "D:\Backup\"
Write-Output "Plug external disk drive. It should be visible as F drive"
pause
$dirsToBackup = @(
    New-Object "backup"
    # New-Object DirToBackup "development"
    # New-Object DirToBackup "Dropbox"
    # New-Object DirToBackup "Google"
)
$dirsToBackup | ForEach-Object {
    mkdir -Path $($pathToPrefix + $_.path) -Force
    xcopy $($pathFromPrefix + $_.path) $($pathToPrefix + $_.path) /D /S /Y /H /EXCLUDE:$defaultListOfExcluded
}
pause