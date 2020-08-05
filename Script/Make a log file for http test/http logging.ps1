Function LogWrite {
    Param ([string]$logstring)

    Add-content $Logfile -value $logstring
}

$date = Get-Date
$datelog = $date.ToString()
$datename = $date.ToString("yyyy-MM-dd")

$logdestination = Read-host -Prompt "Enter destination directory "
$Logfile = $logdestination + " " + $datename + ".log"

#Place URL list file in the below path
$URLListFile = ".\URLList.txt"
$URLList = Get-Content $URLListFile -ErrorAction SilentlyContinue


#For every URL in the list
Foreach ($sites in $URLList) {
    try {
        #For proxy systems
        [System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy()
        [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

        #Web request
        $req = [system.Net.WebRequest]::Create($sites)
        $res = $req.GetResponse()
    }
    catch {
        #Err handling
        $res = $_.Exception.Response
    }
    $req = $null
    
    
    #Getting HTTP status code
    $respondcode = [int]$res.StatusCode

    #Message
    if ($respondcode -eq 200) {
        $message = Write-Output "OK!"        
    }
    else {
        $message = Write-Output "Cannot load the page"
    }

    #Writing on the screen
    Write-Host "$datelog - $respondcode - $sites - $message"

    #make log file
    LogWrite "$datelog - $respondcode - $sites - $message"

    #Disposing response if available
    if ($res) {
        $res.Dispose()
    }

}
[string]$archive = $logdestination + " " + $datename + ".zip"
[string]$logarchive = $Logfile
Compress-Archive -Path $logarchive -Update -DestinationPath $archive

# Write-output "Creating archieve file..."
# $archive = $logfile + " " + $datename + ".zip"
# Add-Type -assembly "system.io.compression.filesystem" 
# [io.compression.zipfile]::CreateFromDirectory($logfile, $archive)