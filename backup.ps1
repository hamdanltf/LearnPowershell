$exclude = ./exclude-folder.ps1
$excludeextension = ./exclude-extension.ps1
$sourcepath = Read-host -Prompt 'Enter directory that you want to backup '
$checkpath = Test-Path $sourcepath

if ($checkpath -eq $true) {
    Write-output "$sourcepath found, contain: "
    get-childitem $sourcepath

    $date = get-date
    $date = $date.ToString("yyyy-MM-dd")
    $destinationpath = Read-host -Prompt "Enter destination directory "
    $destinationpath = $destinationpath+" "+$date
    Write-output "Create backup to $destinationpath, please wait..."

    $tocopy = Get-ChildItem -Path $sourcepath | Where {($exclude -notcontains $_.Name)}

    foreach ($folder in $tocopy){ 
        Copy-Item -Path $sourcepath\$folder -Destination $destinationpath\$folder -Recurse -Force
    }
    
    # Get-ChildItem -Path $destinationpath -Include $exclude -Recurse | foreach { $_.Delete()}

    # do {
    #     $removeextension = Get-ChildItem $destinationpath -directory -recurse | Where { (Get-ChildItem $_.fullName).count -eq 0 } | select -expandproperty FullName $removeextension | Foreach-Object { Remove-Item $_ }
    # } while ($removeextension.count -gt 0)

    Get-ChildItem -Path $destinationpath -Include $excludeextension -Recurse | foreach { $_.Delete()}

    do {
        $dirs = Get-ChildItem $destinationpath -directory -recurse | Where { (Get-ChildItem $_.fullName).count -eq 0 } | select -expandproperty FullName $dirs | Foreach-Object { Remove-Item $_ }
    } while ($dirs.count -gt 0)

    Get-ChildItem $destinationpath

}
elseif ($checkpath -eq $false) {
    Write-output "$sourcepath not found! restart the script"
    ./backup.ps1
}






# $sourcepath =  "D:\Documents\GitHub\LearnPowershell"
# $destinationpath = "D:\Documents\GitHub\backup"


# $tocopy = Get-ChildItem -Path $sourcepath | Where {($_.PSIsContainer) -and ($exclude -notcontains $_.Name)}

