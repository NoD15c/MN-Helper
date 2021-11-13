# Import Ini.txt for working parameter
$host.UI.RawUI.WindowTitle = "MH-Error-Reporter";
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

# show current Timings
     $CurrentError = 0
     
    if($ErrorReportOnOFF -eq "on"){Write-Host -ForegroundColor white -NoNewline "Error Reporter check all: ";Write-Host -ForegroundColor green -NoNewline $timerForError;Write-Host -ForegroundColor white -NoNewline " minutes for errors and send on ";Write-Host -ForegroundColor green -NoNewline $countsForError; Write-Host -ForegroundColor white " wrong Mining States <█████> ."} 
    else {Write-Host -ForegroundColor white -NoNewline "Error Reporter is on status: ";Write-Host -ForegroundColor red $ErrorReportOnOFF;sleep 5}

    # if($ReminderOnOFF -eq "on"){Write-Host -ForegroundColor white -NoNewline "Reminder send all: ";Write-Host -ForegroundColor green -NoNewline $ReminderTimer;Write-Host -ForegroundColor white -NoNewline " minutes a Mail (Backup/Updates) for you. Next send in ";Write-Host -ForegroundColor green -NoNewline $ReminderCount;Write-Host -ForegroundColor white " minutes"} 
    # else {Write-Host -ForegroundColor white -NoNewline "Reminder is on status: ";Write-Host -ForegroundColor red $ReminderOnOFF}

    # if($ReportOnOff -eq "on"){Write-Host -ForegroundColor white -NoNewline "Reporter send all: ";Write-Host -ForegroundColor green -NoNewline $ReportTimer;Write-Host -ForegroundColor white -NoNewline " minutes a ";Write-Host -ForegroundColor green -NoNewline "I´m alive"; Write-Host -ForegroundColor white " message"} 
    # else {Write-Host -ForegroundColor white -NoNewline "Reporter is on status: ";Write-Host -ForegroundColor red $ReportOnOff}

    

# changing menu
Clear-Host
Write-Host "================ Error Reporter ================"
Write-Host -ForegroundColor white -NoNewline "Error Reporter check all: ";Write-Host -ForegroundColor green -NoNewline $timerForError;Write-Host -ForegroundColor white -NoNewline " minutes for errors and send on ";Write-Host -ForegroundColor green -NoNewline $countsForError; Write-Host -ForegroundColor white " wrong Mining States <█████> ."
# minutes to hours

   # Scan Webside     
 
   if($ErrorReportOnOFF -eq "on"){
   # option for later management 
   While ($ErrotTimer -lt "60") {
   
   #if($ErrorReportOnOFF -eq "on"){Write-Host -ForegroundColor white -NoNewline "Current Errors ";Write-Host -ForegroundColor red -NoNewline $CurrentError;$currenterrortime = get-date;Write-Host -ForegroundColor white -NoNewline " last Scan ";Write-Host -ForegroundColor green $currenterrortime}
    #else {Write-Host -ForegroundColor white -NoNewline "Error Reporter is on status: ";Write-Host -ForegroundColor red $ErrorReportOnOFF}
   
   if($ErrorReportOnOFF -eq "on"){ $parsing=Invoke-WebRequest "http://127.0.0.1:37223/api/dashboard/stats"
        #if($ErrorReportOnOFF -eq "on"){ $parsing=Invoke-WebRequest "google.de"
         $parsing.ParsedHtml.body.innerHTML
         $parsing.ParsedHtml.body.innerText
         $parsing.RawContent > .\MNWebContent.txt}
    # Filter and count if error
         $InfoForMatch=Select-String -path .\MNWebContent.txt -pattern "█████"
         $matchNotMining = $InfoForMatch -match "<█████>"
         $matchMining = $InfoForMatch -match '\[█████]'
     if ($matchMining -eq "True"){write-host -ForegroundColor white -NoNewline "get a ";write-host -ForegroundColor green -NoNewline "[█████] ";write-host -ForegroundColor white -NoNewline "back. ";$CurrentError = "0";write-host -ForegroundColor white -NoNewline "Set current errors to ";write-host -ForegroundColor green -NoNewline  "0 "
     ;$currenterrortime = get-date;Write-Host -ForegroundColor white -NoNewline "last Scan ";Write-Host -ForegroundColor green $currenterrortime} 
     else{$CurrentError = [int]$CurrentError + 1;Write-Host -ForegroundColor white -NoNewline "get a ";write-host -ForegroundColor red -NoNewline "<█████> ";Write-Host -ForegroundColor white -NoNewline "back. Set Current errors to ";Write-Host -ForegroundColor red -NoNewline $CurrentError;$currenterrortime = get-date;Write-Host -ForegroundColor white -NoNewline " last Scan ";Write-Host -ForegroundColor red $currenterrortime}
     if ($CurrentError -eq $countsForError){
                                            $MailAttachment = ".\MNWebContent.txt"
                                            $pw = Get-Content .\MailPW.txt | ConvertTo-SecureString
                                            $cred = New-Object System.Management.Automation.PSCredential "$MailSender", $pw
                                            Send-MailMessage -From $MailSender -to $MailReceiver  -Subject $MailSubjectError -Body $MailBodyError -BodyAsHtml -SmtpServer $MailSMTP -Port $MailSMTPPort -UseSsl -Credential $cred -Attachments $MailAttachment -encoding ([System.Text.Encoding]::UTF8)
                                                                      
                                            $datum = get-date;write-host -ForegroundColor green -NoNewline  "-> -> -> send mail on ";write-host -ForegroundColor white $datum;$CurrentError = 0;$ErrotTimer = $ErrotTimer +1}
    $timerForErrorMinutes = [int]$timerForError*60
   
    sleep $timerForErrorMinutes
    }


    sleep 5
    

   } 
   
   

   Echo "Program ends @" 
   get-date
