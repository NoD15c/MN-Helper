# Import Ini.txt for working parameter
$host.UI.RawUI.WindowTitle = "MH-Scheduler";
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
} else {Write-Host -ForegroundColor Red -NoNewline "No ini file found sorry, please create a new ini.txt file whit the ";Write-Host -ForegroundColor yellow "MH-Helper-Setup.ps1"}

Write-Host -ForegroundColor yellow -NoNewline "ini.txt ";sleep 1; Write-Host -ForegroundColor white -NoNewline "is imported ";sleep 1;Write-Host -ForegroundColor green "✔Check"
sleep 2

$currentTime = Get-Date
# changing menu
Clear-Host
    Write-Host "================ MN - Scheduler ================"

if($ReminderOnOFF -eq "on"){
    
   While ($ErrotTimer -lt "6") {
                                
   
   
# show current Timings
     
     
    #if($ErrorReportOnOFF -eq "on"){Write-Host -ForegroundColor white -NoNewline "Error Reporter check all: ";Write-Host -ForegroundColor green -NoNewline $timerForError;Write-Host -ForegroundColor white -NoNewline " minutes for errors and send on ";Write-Host -ForegroundColor green -NoNewline $countsForError; Write-Host -ForegroundColor white -NoNewline " wrong Mining States <█████> . Current Counts on Error ";Write-Host -ForegroundColor green $CurrentError} 
    #else {Write-Host -ForegroundColor white -NoNewline "Error Reporter is on status: ";Write-Host -ForegroundColor red $ErrorReportOnOFF;sleep 5}

    if($ReminderOnOFF -eq "on"){Write-Host -ForegroundColor white -NoNewline "Reminder send all: ";Write-Host -ForegroundColor green -NoNewline $ReminderTimer;Write-Host -ForegroundColor white -NoNewline " hours a Mail (Backup/Updates) for you. "} 
    else {Write-Host -ForegroundColor white -NoNewline "Reminder is on status: ";Write-Host -ForegroundColor red $ReminderOnOFF}

    #if($ReportOnOff -eq "on"){Write-Host -ForegroundColor white -NoNewline "Reporter send all: ";Write-Host -ForegroundColor green -NoNewline $ReportTimer;Write-Host -ForegroundColor white -NoNewline " hours a ";Write-Host -ForegroundColor green -NoNewline "I´m alive"; Write-Host -ForegroundColor white " message"} 
    #else {Write-Host -ForegroundColor white -NoNewline "Reporter is on status: ";Write-Host -ForegroundColor red $ReportOnOff}

    
    # show time next Email
    
    
    $hours = new-timespan -hours $ReminderTimer
    $sendtime= (get-date) + $hours
    $sleeptime = [int]$ReminderTimer*3600
    
    if($ReminderOnOFF -eq "on"){write-Host -ForegroundColor white -NoNewline "The next sending @ " $SendTime}
    if($ReminderOnOFF -eq "on"){sleep $sleeptime;write-Host -ForegroundColor green " -->> -->> send Mail";
                                            
                                            $pw = Get-Content .\MailPW.txt | ConvertTo-SecureString
                                            $cred = New-Object System.Management.Automation.PSCredential "$MailSender", $pw
                                            Send-MailMessage -From $MailSender -to $MailReceiver  -Subject $MailSubjectReminder -Body $MailBodyReminder -BodyAsHtml -SmtpServer $MailSMTP -Port $MailSMTPPort -UseSsl -Credential $cred -encoding ([System.Text.Encoding]::UTF8)  
                                            }
    } 
   } else{Write-Host -ForegroundColor white -NoNewline "Reminder settings are: ";Write-Host -ForegroundColor red -NoNewline $ReminderOnOFF;Write-Host -ForegroundColor white " nothing to do !"}
   

   Echo "Program ends @" 
   get-date