Write-Host ""
Write-Host "Would you like to check a file with VirusTotal?"
Write-Host ""
Write-Host "A) Yes!"
Write-Host "B) No."
Write-Host ""
$response = Read-Host -Prompt "Please select 'A' or 'B'"
Write-Host ""

if ('A'.ToUpper() -eq $response) {
    #Get the file name
    $filepath = Read-Host -Prompt "Please enter file path for the file you would like to check (i.e. C:\somefolder\hello.txt)"

    #Get the hash of file in the folder
    $hash = Get-ChildItem -Path "$filepath" | Foreach-Object { Get-FileHash $_.FullName } | Select Hash

    #Tell 'em what the hash is
    Write-Host ""
    Write-Host "Your file hash is $hash, now we'll run it through VirusTotal!"

    Start-Sleep -Seconds 1
    
    #Query sigcheck for VirusTotal look up
    $vtanswer = Get-ChildItem -Path "$filepath" | Foreach-Object { sigcheck -nobanner -vt -vr -c $filepath > C:\somefolder\results.csv }

    #Import Result to screen
    Import-Csv C:\somefolder\results.csv

    Write-Host ""
    Write-Host "You can view the results of your VirusTotal lookup at the following path: C:\somefolder\results.csv"
}
elseif ('B'.ToUpper() -eq $response) {
    #End the script
    Write-Host "See you next time!"
    exit


}
