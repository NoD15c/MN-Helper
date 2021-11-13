
# Import Ini.txt for working parameter
$host.UI.RawUI.WindowTitle = "MH-Login-Reporter";
if(Test-Path .\ini.txt) {
$csv = Import-CSV '.\ini.txt' -Delimiter ','
$csv | %{
   # Mail Info
    $MailSender = $_.'MailSender'
    $MailReceiver = $_.'MailReceiver'
    $MailSMTP = $_.'MailSMTP'
    $MailSMTPPort = $_.'MailSMTPPort'
        # Error Setting
        $MailSubjectError = $_.'MailSubjectError'
        $MailBodyError = $_.'MailBodyError'  
        $countsForError = $_.'countsForError'
        $timerForError = $_.'timerForError'
        $ErrorReportOnOFF = $_.'ErrorReportOnOFF'
            # Reminder Setting
            $MailSubjectReminder = $_.'MailSubjectReminder'
            $MailBodyReminder = $_.'MailBodyReminder'
            $ReminderTimer = $_.'ReminderTimer'
            $ReminderOnOFF = $_.'ReminderOnOFF'
                # Reporter Setting 
                $MailSubjectReporter = $_.'MailSubjectReporter'
                $MailBodyReporter = $_.'MailBodyReporter'
                $ReportTimer = $_.'ReportTimer'
                $ReportOnOff = $_.'ReportOnOff'
                     # Login Alert Setting
                    $MailSubjectAlert = $_.'MailSubjectAlert'
                    $MailBodyAlert = $_.'MailBodyAlert'
                    $AlertTimer = $_.'AlertTimer'
                    $AlertOnOff = $_.'AlertOnOff'
    # usw.
}
} else {Write-Host -ForegroundColor Red -NoNewline "No ini file found sorry, please create a new ini.txt file whit the ";Write-Host -ForegroundColor yellow "MH-Helper-Setup.ps1";exit}

Write-Host -ForegroundColor yellow -NoNewline "ini.txt ";sleep 1; Write-Host -ForegroundColor white -NoNewline "is imported ";sleep 2;Write-Host -ForegroundColor green "✔Check"
sleep 1

# changing menu
Clear-Host
Write-Host "================ Alert Reporter ================"

$date = Get-Date

if($AlertOnOFF -eq "on"){Write-Host -ForegroundColor white -NoNewline "Alert Reporter is runnin and check all: ";Write-Host -ForegroundColor green -NoNewline $Alerttimer;Write-Host -ForegroundColor white -NoNewline " secounds for a remotelogon and send an Mail Start on: ";Write-Host -ForegroundColor green $Date} 
    else {Write-Host -ForegroundColor white -NoNewline "Alert Reporter is on status: ";Write-Host -ForegroundColor red $AlertOnOFF;sleep 5}

# $Zaehler -> Security settings to max 300 send mails

$zaehler=0
# scan for changing Userlogon
do {

$Status1 = Get-WinEvent -Logname 'Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational' -FilterXPath  "*[System[Provider[@Name='Microsoft-Windows-TerminalServices-RemoteConnectionManager'] and (EventID=1149) ]]" | %{
        $event = [xml]$_.ToXML()
        [pscustomobject]@{'Time'=$_.TimeCreated;'Username'=$event.Event.UserData.EventXML.Param1;'Source-IP'=$event.Event.UserData.EventXML.Param3} 
} 


$status1 |Select-Object –first 1 | %{
   # Mail Info
    $timestampr = $_.'Time'
    $username = $_.'Username'
    $Sourceip = $_.'Source-IP'

    }
    # time between the scans
    sleep $AlertTimer
    


    $Status2 = Get-WinEvent -Logname 'Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational' -FilterXPath  "*[System[Provider[@Name='Microsoft-Windows-TerminalServices-RemoteConnectionManager'] and (EventID=1149) ]]" | %{
        $event = [xml]$_.ToXML()
        [pscustomobject]@{'Time'=$_.TimeCreated;'Username'=$event.Event.UserData.EventXML.Param1;'Source-IP'=$event.Event.UserData.EventXML.Param3} 
} 


$status2 |Select-Object –first 1 | %{
   # Mail Info
    $timestampr2 = $_.'Time'
    $username2 = $_.'Username'
    $Sourceip2 = $_.'Source-IP'

    }
    
$htmlboyd = "
<html><body>
<font color='FF0000'>$MailBodyAlert</font><br /><br />
<body><html>"


if ($timestampr -eq $timestampr2){}else{Write-Host "last login " -ForegroundColor white -NoNewline; Write-Host $timestampr2 -ForegroundColor red -NoNewline; Write-Host " send Email " -ForegroundColor green;$zaehler = $zaehler + 1;
                                            $pw = Get-Content .\MailPW.txt | ConvertTo-SecureString
                                            $cred = New-Object System.Management.Automation.PSCredential "$MailSender", $pw
                                            Send-MailMessage -From $MailSender -to $MailReceiver  -Subject $MailSubjectAlert -Body $htmlboyd -BodyAsHtml -SmtpServer $MailSMTP -Port $MailSMTPPort -UseSsl -Credential $cred -encoding ([System.Text.Encoding]::UTF8)
                                            
                                           }



		} Until ($Zaehler -eq "300") 