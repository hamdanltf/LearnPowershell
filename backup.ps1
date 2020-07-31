# $exclude = ".\exclude.txt"
$exclude = @('*.txt','*.ps1')
$originpath = Read-host -Prompt 'Enter directory that you want to backup '
$checkpath = Test-Path $originpath

if ($checkpath -eq $true) {
    Write-output "$originpath found"
    Write-output "Following directory will be backuped"
    Get-ChildItem $originpath

    $destinationpath = Read-host -Prompt 'Enter backup destination..'
    Write-output "Backuping to $destinationpath please wait...."

    Get-ChildItem $originpath -Recurse -Exclude $exclude | Copy-Item -Destination {Join-Path $destinationpath $_.FullName.Substring($originpath.length)}

    # Copy-Item -Path $originpath -Destination $destinationpath -Recurse -Exclude $exclude
    Get-ChildItem $destinationpath

    # $checkpath = Test-Path $destinationpath
    # if ($checkpath -eq $true) {
    #     Write-output "Backup will stored on $destinationpath"
    # }
    # elseif ($checkpath -eq $false) {
    #     Write-output "Directory not-found! creating new directory..."
    #     New-Item -ItemType Directory -Name $destinationpath
    # }
}
elseif ($checkpath -eq $false) {
    Write-output "$originpath not-found" 
    ./backup.ps1   
}