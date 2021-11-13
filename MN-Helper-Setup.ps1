Echo " "
$host.UI.RawUI.WindowTitle = "MH-Setup";
Echo " "
Write-Host -ForegroundColor white "welcome to the MN-Helper @NoD15c"
Echo " "
Echo " "
sleep 1

# prof of exist ini.txt and reading ini file and set up variables


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

} else {Write-Host -ForegroundColor Red "No ini file found sorry, create a new ini.txt file in your directory"; New-Item -Path '.\ini.txt' -ItemType File}



Write-Host -NoNewline -ForegroundColor white 'ini.txt exist and importet ';sleep 1; Write-Host -ForegroundColor green '✔Check'
sleep 1

# prof variables are set and not 0 and Setup Variables

    # Mail Setting
if ($MailSender -eq $null -or $MailSender -eq "" -or $MailSender -eq $null -or $MailSender -eq "" -or $MailReceiver -eq $null -or $MailReceiver -eq "" -or $MailSMTP -eq $null -or $MailSMTP -eq ""){Write-Host "Mail Setting -> all needed infos for the mail account " -ForegroundColor green}
if ($MailSender -eq $null -or $MailSender -eq "") {Do{Write-Host "missing ini variable:MailSender " -ForegroundColor red -NoNewline; $MailSender = read-Host '->> please insert MailSender (Email Format)'}While (($MailSender -eq $null) -or ($MailSender -eq ""))}
if ($MailReceiver -eq $null -or $MailReceiver -eq "") {Do{Write-Host "missing ini variable:MailReceiver " -ForegroundColor red -NoNewline; $MailReceiver = read-Host '->> please insert MailReceiver (Email Format)'}While (($MailReceiver -eq $null) -or ($MailReceiver -eq ""))}
if ($MailSMTP -eq $null -or $MailSMTP -eq "") {Do{Write-Host "missing ini variable:MailSMTP " -ForegroundColor red -NoNewline; $MailSMTP = read-Host '->> please insert MailSMTP(Email SMTP Server)'}While (($MailSMTP -eq $null) -or ($MailSMTP -eq ""))}
if ($MailSMTPPort -eq $null -or $MailSMTPPort -eq "") {Do{Write-Host "missing ini variable:MailSMTPPort " -ForegroundColor red -NoNewline; $MailSMTPPort = read-Host '->> please insert MailSMTPPort (SMTP Port)'}While (($MailSMTPPort -eq $null) -or ($MailSMTPPort -eq ""))}
    # Error Setting
    if ($MailSubjectError -eq $null -or $MailSubjectError -eq "" -or $MailBodyError -eq $null -or $MailBodyError -eq "" -or $ErrorReportOnOFF -eq $null -or $ErrorReportOnOFF -eq "" -or $countsForError -eq $null -or $countsForError -eq "" -or $timerForError -eq $null -or $timerForError -eq ""){Write-Host "Error Report Setting -> all Settings how to handle errors" -ForegroundColor green}
    if ($MailSubjectError -eq $null -or $MailSubjectError -eq "") {Do{Write-Host "missing ini variable:MailSubjectError " -ForegroundColor red -NoNewline; $MailSubjectError = read-Host '->> please insert MailSubjectError (Text for the Mail Subject on Error)'}While (($MailSubjectError -eq $null) -or ($MailSubjectError -eq ""))}
    if ($MailBodyError -eq $null -or $MailBodyError -eq "") {Do{Write-Host "missing ini variable:MailBodyError " -ForegroundColor red -NoNewline; $MailBodyError = read-Host '->> please insert MailBodyError (Text for Body on Error)'}While (($MailBodyError -eq $null) -or ($MailBodyError -eq ""))}  
    if ($ErrorReportOnOFF -eq $null -or $ErrorReportOnOFF -eq "") {Do{Write-Host "missing ini variable:ErrorReportOnOFF " -ForegroundColor red -NoNewline; $ErrorReportOnOFF = read-Host '->> please insert ErrorReportOnOFF (Please use on/off)'}While (($ErrorReportOnOFF -eq $null) -or ($ErrorReportOnOFF -eq "") -or (($ErrorReportOnOFF -ne "on") -and ($ErrorReportOnOFF -ne "off")))}
    if ($countsForError -eq $null -or $countsForError -eq "") {Do{Write-Host "missing ini variable:countsForError " -ForegroundColor red -NoNewline; $countsForError = read-Host '->> please insert countsForError (how many error untill send)'}While (($countsForError -eq $null) -or ($countsForError -eq ""))}
    if ($timerForError -eq $null -or $timerForError -eq "") {Do{Write-Host "missing ini variable:timerForError " -ForegroundColor red -NoNewline; $timerForError = read-Host '->> please insert timerForError(time between counts in minutes)'}While (($timerForError -eq $null) -or ($timerForError -eq ""))}     
        # Reminder Setting
        if ($MailSubjectReminder -eq $null -or $MailSubjectReminder -eq "" -or $MailSubjectReminder -eq $null -or $MailSubjectReminder -eq "" -or $MailBodyReminder -eq $null -or $MailBodyReminder -eq "" -or $ReminderTimer -eq $null -or $ReminderTimer -eq "" -or $ReminderOnOFF -eq $null -or $ReminderOnOFF -eq ""){Write-Host "Reminder Setting -> Setting for a Reminding shedule (writes you a mail every hours you have setup" -ForegroundColor green}
        if ($MailSubjectReminder -eq $null -or $MailSubjectReminder -eq "") {Do{Write-Host "missing ini variable:MailSubjectReminder " -ForegroundColor red -NoNewline; $MailSubjectReminder = read-Host '->> please insert MailSubjectReminder(Text for the Mail Subject on Reminder)'}While (($MailSubjectReminder -eq $null) -or ($MailSubjectReminder -eq ""))}
        if ($MailBodyReminder -eq $null -or $MailBodyReminder -eq "") {Do{Write-Host "missing ini variable:MailBodyReminder " -ForegroundColor red -NoNewline; $MailBodyReminder = read-Host '->> please insert MailBodyReminder(Text for Body on Reminder)'}While (($MailBodyReminder -eq $null) -or ($MailBodyReminder -eq ""))}
        if ($ReminderTimer -eq $null -or $ReminderTimer -eq "") {Do{Write-Host "missing ini variable:ReminderTimer " -ForegroundColor red -NoNewline; $ReminderTimer = read-Host '->> please insert ReminderTimer(counts in hours )'}While (($ReminderTimer -eq $null) -or ($ReminderTimer -eq ""))}
        if ($ReminderOnOFF -eq $null -or $ReminderOnOFF -eq "") {Do{Write-Host "missing ini variable:ReminderOnOFF " -ForegroundColor red -NoNewline; $ReminderOnOFF = read-Host '->> please insert ReminderOnOFF(Please use on/off)'}While (($ReminderOnOFF -eq $null) -or ($ReminderOnOFF -eq "") -or (($ReminderOnOFF -ne "on") -and ($ReminderOnOFF -ne "off")))}
            # Reporter Setting
            if ($MailSubjectReporter -eq $null -or $MailSubjectReporter -eq "" -or $MailBodyReporter -eq $null -or $MailBodyReporter -eq "" -or $ReportTimer -eq $null -or $ReportTimer -eq "" -or $ReportOnOff -eq $null -or $ReportOnOff -eq ""){Write-Host "Reporter Setting -> send you every hours you set, a mail whit the current infos " -ForegroundColor green}
            if ($MailSubjectReporter -eq $null -or $MailSubjectReporter -eq "") {Do{Write-Host "missing ini variable:MailSubjectReporter " -ForegroundColor red -NoNewline; $MailSubjectReporter = read-Host '->> please insert MailSubjectReporter(Text for the Mail Subject on Reporter)'}While (($MailSubjectReporter -eq $null) -or ($MailSubjectReporter -eq ""))}
            if ($MailBodyReporter -eq $null -or $MailBodyReporter -eq "") {Do{Write-Host "missing ini variable:MailBodyReporter " -ForegroundColor red -NoNewline; $MailBodyReporter = read-Host '->> please insert MailBodyReporter(Text for Body on Reporter)'}While (($MailBodyReporter -eq $null) -or ($MailBodyReporter -eq ""))}
            if ($ReportTimer -eq $null -or $ReportTimer -eq "") {Do{Write-Host "missing ini variable:ReportTimer " -ForegroundColor red -NoNewline; $ReportTimer = read-Host '->> please insert ReportTimer(counts in hours)'}While (($ReportTimer -eq $null) -or ($ReportTimer -eq ""))}
            if ($ReportOnOff -eq $null -or $ReportOnOff -eq "") {Do{Write-Host "missing ini variable:ReportOnOff" -ForegroundColor red -NoNewline; $ReportOnOff = read-Host '->> please insert ReportOnOff(Please use on/off)'}While (($ReportOnOff -eq $null) -or ($ReportOnOff -eq "") -or (($ReportOnOff -ne "on") -and ($ReportOnOff -ne "off")))}
                # Login Alert Setting
                if ($MailSubjectAlert -eq $null -or $MailSubjectAlert -eq "" -or $MailBodyAlert -eq $null -or $MailBodyAlert -eq "" -or $AlertTimer -eq $null -or $AlertTimer -eq "" -or $AlertOnOff -eq $null -or $AlertOnOff -eq ""){Write-Host "Alert Setting -> send you a Mail if Remote Logon happens " -ForegroundColor green}
                if ($MailSubjectAlert -eq $null -or $MailSubjectAlert -eq "") {Do{Write-Host "missing ini variable:MailSubjectAlert " -ForegroundColor red -NoNewline; $MailSubjectAlert = read-Host '->> please insert MailSubjectAlert '}While (($MailSubjectAlert -eq $null) -or ($MailSubjectAlert -eq ""))}
                if ($MailBodyAlert -eq $null -or $MailBodyAlert -eq "") {Do{Write-Host "missing ini variable:MailBodyAlert " -ForegroundColor red -NoNewline; $MailBodyAlert = read-Host '->> please insert MailBodyAlert '}While (($MailBodyAlert -eq $null) -or ($MailBodyAlert -eq ""))}
                if ($AlertTimer -eq $null -or $AlertTimer -eq "") {Do{Write-Host "missing ini variable:AlertTimer " -ForegroundColor red -NoNewline; $AlertTimer = read-Host '->> please insert AlertTimer in Secounds (time between logon scan interval ) '}While (($AlertTimer -eq $null) -or ($AlertTimer -eq ""))}
                if ($AlertOnOff -eq $null -or $AlertOnOff -eq "") {Do{Write-Host "missing ini variable:AlertOnOff " -ForegroundColor red -NoNewline; $AlertOnOff = read-Host '->> please insert AlertOnOff (Please use on/off)'}While (($AlertOnOff -eq $null) -or ($AlertOnOff -eq "") -or (($AlertOnOff -ne "on") -and ($AlertOnOff -ne "off")))}
           
           
sleep 1
# writing variables to the ini.txt

$testObject = [pscustomobject]@{'MailSender' = $MailSender; 'MailReceiver' = $MailReceiver; 'MailSMTP' = $MailSMTP; 'MailSMTPPort' = $MailSMTPPort; 'MailSubjectError' = $MailSubjectError; 'MailBodyError' = $MailBodyError; 'countsForError' = $countsForError; 'ErrorReportOnOFF' = $ErrorReportOnOFF; 'timerForError' = $timerForError; 'MailSubjectReminder' = $MailSubjectReminder; 'MailBodyReminder' = $MailBodyReminder; 'ReminderTimer' = $ReminderTimer; 'ReminderOnOFF' = $ReminderOnOFF; 'MailSubjectReporter' = $MailSubjectReporter; 'MailBodyReporter' = $MailBodyReporter; 'ReportTimer' = $ReportTimer; 'ReportOnOff' = $ReportOnOff; 'MailSubjectAlert' = $MailSubjectAlert; 'MailBodyAlert' = $MailBodyAlert; 'AlertTimer' = $AlertTimer; 'AlertOnOff' = $AlertOnOff}
$testObject | Export-Csv -Path ./ini.txt

Write-Host -NoNewline -ForegroundColor white 'all needed variables are filed in or importet ';sleep 1;Write-Host -ForegroundColor green '✔Check'

sleep 1

# prof of exist USER / PW file for sending Email


if(Test-Path .\MailPW.txt) {Write-Host -NoNewline -ForegroundColor white "MailPW.txt exist";sleep 1; Write-Host -ForegroundColor green '✔Check'} else{
Write-Host -ForegroundColor Red "MAilPW.txt is missing please insert new Credentilas for the Email-Acount:"
(Get-Credential).password | ConvertFrom-SecureString > .\MailPW.txt
}

# $MAilPW = Get-Content .\MailPW.txt | ConvertTo-SecureString
# $cred = New-Object System.Management.Automation.PSCredential "$MailSender", $MailPW

Write-Host -NoNewline -ForegroundColor white 'MailPW created or importet ';sleep 1; Write-Host -ForegroundColor green '✔Check'

sleep 1

Echo "All needed informations are done"

sleep 1


# changing menu 1
Clear-Host

    
    # Mail settings
    Write-Host "============ Mail settings =============="
        Write-Host " 1: " -ForegroundColor white -NoNewline; Write-Host "MailSender: " -ForegroundColor red -NoNewline; Write-Host $MailSender
        Write-Host " 2: " -ForegroundColor white -NoNewline;Write-Host "MailReceiver: " -ForegroundColor red -NoNewline; Write-Host $MailReceiver
        Write-Host " 3: " -ForegroundColor white -NoNewline;Write-Host "MailSMTP: " -ForegroundColor red -NoNewline; Write-Host $MailSMTP
        Write-Host " 4: " -ForegroundColor white -NoNewline;Write-Host "MailSMTPPort: " -ForegroundColor red -NoNewline; Write-Host $MailSMTPPort
          # Error Setting
          Write-Host "============ Error Setting =============="
            Write-Host " 5: " -ForegroundColor white -NoNewline;Write-Host "MailSubjectError: " -ForegroundColor red -NoNewline; Write-Host $MailSubjectError
            Write-Host " 6: " -ForegroundColor white -NoNewline;Write-Host "MailBodyError: " -ForegroundColor red -NoNewline; Write-Host $MailBodyError
            Write-Host " 7: " -ForegroundColor white -NoNewline;Write-Host "CountsForError: " -ForegroundColor red -NoNewline; Write-Host $countsForError       
            Write-Host " 8: " -ForegroundColor white -NoNewline;Write-Host "TimerForError: " -ForegroundColor red -NoNewline; Write-Host $timerForError
            Write-Host " 9: " -ForegroundColor white -NoNewline;Write-Host "ErrorReportOnOFF: " -ForegroundColor red -NoNewline; Write-Host $ErrorReportOnOFF
            
                # Reminder Setting
                Write-Host "========== Reminder Setting ============="
                Write-Host "10: " -ForegroundColor white -NoNewline;Write-Host "MailSubjectReminder: " -ForegroundColor red -NoNewline; Write-Host $MailSubjectReminder
                Write-Host "11: " -ForegroundColor white -NoNewline;Write-Host "MailBodyReminder: " -ForegroundColor red -NoNewline; Write-Host $MailBodyReminder
                Write-Host "12: " -ForegroundColor white -NoNewline;Write-Host "ReminderTimer: " -ForegroundColor red -NoNewline; Write-Host $ReminderTimer
                Write-Host "13: " -ForegroundColor white -NoNewline;Write-Host "ReminderOnOFF: " -ForegroundColor red -NoNewline; Write-Host $ReminderOnOFF
                    # Reporter Setting 
                    Write-Host "========= Reporter Settings ============="
                    Write-Host "14: " -ForegroundColor white -NoNewline;Write-Host "MailSubjectReporter: " -ForegroundColor red -NoNewline; Write-Host $MailSubjectReporter
                    Write-Host "15: " -ForegroundColor white -NoNewline;Write-Host "MailBodyReporter: " -ForegroundColor red -NoNewline; Write-Host $MailBodyReporter
                    Write-Host "16: " -ForegroundColor white -NoNewline;Write-Host "ReportTimer: " -ForegroundColor red -NoNewline; Write-Host $ReportTimer
                    Write-Host "17: " -ForegroundColor white -NoNewline;Write-Host "ReportOnOff: " -ForegroundColor red -NoNewline; Write-Host $ReportOnOff
                        # Alert Setting 
                        Write-Host "========= Reporter Settings ============="
                        Write-Host "18: " -ForegroundColor white -NoNewline;Write-Host "MailSubjectAlert: " -ForegroundColor red -NoNewline; Write-Host $MailSubjectAlert
                        Write-Host "19: " -ForegroundColor white -NoNewline;Write-Host "MailBodyAlert: " -ForegroundColor red -NoNewline; Write-Host $MailBodyAlert
                        Write-Host "20: " -ForegroundColor white -NoNewline;Write-Host "AlertTimer: " -ForegroundColor red -NoNewline; Write-Host $AlertTimer
                        Write-Host "21: " -ForegroundColor white -NoNewline;Write-Host "AlertOnOff: " -ForegroundColor red -NoNewline; Write-Host $AlertOnOff
                            # rest
                            Write-Host "========================================="
                            Write-Host " T: " -ForegroundColor white -NoNewline;Write-Host "Test Email" -ForegroundColor red
                            Write-Host " B: " -ForegroundColor white -NoNewline;Write-Host "Backup the settings" -ForegroundColor red
                            Write-Host " S: " -ForegroundColor white -NoNewline;Write-Host "Save the settings" -ForegroundColor red
                            Write-Host " R: " -ForegroundColor white -NoNewline;Write-Host "Reset Mail Credential" -ForegroundColor red
                            Write-Host "========================================="
                            Write-Host " Q: " -ForegroundColor white -NoNewline;Write-Host "Quit" -ForegroundColor red
                            Write-Host "========================================="

while(($inp = Read-Host "To change a variable , use the Numbers, Q for End and N for the next step ") -ne "N") {

switch($inp){
1 {do{Write-Host "Change for: MailSender " -ForegroundColor red -NoNewline; $MailSender = read-Host '->> please insert MailSender (Email Format)'}while(($MailSender -eq $null) -or ($MailSender -eq ""))}
2 {Do{Write-Host "Change for: MailReceiver " -ForegroundColor red -NoNewline; $MailReceiver = read-Host '->> please insert MailReceiver (Email Format)'}While (($MailReceiver -eq $null) -or ($MailReceiver -eq ""))}
3 {Do{Write-Host "Change for: MailSMTP " -ForegroundColor red -NoNewline; $MailSMTP = read-Host '->> please insert MailSMTP(Email SMTP Server)'}While (($MailSMTP -eq $null) -or ($MailSMTP -eq ""))}
4 {Do{Write-Host "Change for: MailSMTPPort " -ForegroundColor red -NoNewline; $MailSMTPPort = read-Host '->> please insert MailSMTPPort (SMTP Port)'}While (($MailSMTPPort -eq $null) -or ($MailSMTPPort -eq ""))}
    # Error Setting
    5 {Do{Write-Host "Change for: MailSubjectError " -ForegroundColor red -NoNewline; $MailSubjectError = read-Host '->> please insert MailSubjectError (Text for the Mail Subject on Error)'}While (($MailSubjectError -eq $null) -or ($MailSubjectError -eq ""))}
    6 {Do{Write-Host "Change for: MailBodyError " -ForegroundColor red -NoNewline; $MailBodyError = read-Host '->> please insert MailBodyError (Text for Body on Error)'}While (($MailBodyError -eq $null) -or ($MailBodyError -eq ""))}
    7 {Do{Write-Host "Change for: countsForError " -ForegroundColor red -NoNewline; $countsForError = read-Host '->> please insert countsForError (how many error till send)'}While (($countsForError -eq $null) -or ($countsForError -eq ""))} 
    8 {Do{Write-Host "Change for: timerForError " -ForegroundColor red -NoNewline; $timerForError = read-Host '->> please insert timerForError(time between counts in minutes)'}While (($timerForError -eq $null) -or ($timerForError -eq ""))}     
    9 {Do{Write-Host "Change for: ErrorReportOnOFF " -ForegroundColor red -NoNewline; $ErrorReportOnOFF = read-Host '->> please insert ErrorReportOnOFF (Please use on/off)'}While (($ErrorReportOnOFF -eq $null) -or ($ErrorReportOnOFF -eq "") -or (($ErrorReportOnOFF -ne "on") -and ($ErrorReportOnOFF -ne "off")))}
        # Reminder Setting
        10 {Do{Write-Host "Change for: MailSubjectReminder " -ForegroundColor red -NoNewline; $MailSubjectReminder = read-Host '->> please insert MailSubjectReminder(Text for the Mail Subject on Reminder)'}While (($MailSubjectReminder -eq $null) -or ($MailSubjectReminder -eq ""))}
        11 {Do{Write-Host "Change for: MailBodyReminder " -ForegroundColor red -NoNewline; $MailBodyReminder = read-Host '->> please insert MailBodyReminder(Text for Body on Reminder)'}While (($MailBodyReminder -eq $null) -or ($MailBodyReminder -eq "" ))}
        12 {Do{Write-Host "Change for: ReminderTimer " -ForegroundColor red -NoNewline; $ReminderTimer = read-Host '->> please insert ReminderTimer(Date and Time for Schedule - counts in hours)'}While (($ReminderTimer -eq $null) -or ($ReminderTimer -eq ""))}
        13 {Do{Write-Host "Change for: ReminderOnOFF " -ForegroundColor red -NoNewline; $ReminderOnOFF = read-Host '->> please insert ReminderOnOFF(Please use on/off)'}While (($ReminderOnOFF -eq $null) -or ($ReminderOnOFF -eq "") -or (($ReminderOnOFF -ne "on") -and ($ReminderOnOFF -ne "off")))}
            # Reporter Setting
            14 {Do{Write-Host "Change for: MailSubjectReporter " -ForegroundColor red -NoNewline; $MailSubjectReporter = read-Host '->> please insert MailSubjectReporter(Text for the Mail Subject on Reporter)'}While (($MailSubjectReporter -eq $null) -or ($MailSubjectReporter -eq ""))}
            15 {Do{Write-Host "Change for: MailBodyReporter " -ForegroundColor red -NoNewline; $MailBodyReporter = read-Host '->> please insert MailBodyReporter(Text for Body on Reporter)'}While (($MailBodyReporter -eq $null) -or ($MailBodyReporter -eq ""))}
            16 {Do{Write-Host "Change for: ReportTimer " -ForegroundColor red -NoNewline; $ReportTimer = read-Host '->> please insert ReportTimer(Date and Time for Daily Schedule - counts in hours)'}While (($ReportTimer -eq $null) -or ($ReportTimer -eq ""))}
            17 {Do{Write-Host "Change for: ReportOnOff" -ForegroundColor red -NoNewline; $ReportOnOff = read-Host '->> please insert ReportOnOff(Please use on/off)'}While (($ReportOnOff -eq $null) -or ($ReportOnOff -eq "") -or (($ReportOnOff -ne "on") -and ($ReportOnOff -ne "off")))}
                # Alert Setting
                18 {Do{Write-Host "Change for: MailSubjectAlert " -ForegroundColor red -NoNewline; $MailSubjectAlert = read-Host '->> please insert MailSubjectAlert (Text for the Mail Subject on Alert)'}While (($MailSubjectAlert -eq $null) -or ($MailSubjectAlert -eq ""))}
                19 {Do{Write-Host "Change for: MailBodyAlert " -ForegroundColor red -NoNewline; $MailBodyAlert = read-Host '->> please insert MailBodyAlert (Text for Body on Alert)'}While (($MailBodyAlert -eq $null) -or ($MailBodyAlert -eq ""))}
                20 {Do{Write-Host "Change for: AlertTimer " -ForegroundColor red -NoNewline; $AlertTimer = read-Host '->> please insert Scantime for Logon in Secounds'}While (($AlertTimer -eq $null) -or ($AlertTimer -eq ""))}
                21 {Do{Write-Host "Change for: AlertOnOff" -ForegroundColor red -NoNewline; $AlertOnOff = read-Host '->> please insert AlertOnOff(Please use on/off)'}While (($AlertOnOff -eq $null) -or ($AlertOnOff -eq "") -or (($AlertOnOff -ne "on") -and ($AlertOnOff -ne "off")))}
     
                    T {
                        $MailAttachment = ".\ini.txt"
                        $pw = Get-Content .\MailPW.txt | ConvertTo-SecureString
                        $cred = New-Object System.Management.Automation.PSCredential "$MailSender", $pw
                        Send-MailMessage -From $MailSender -to $MailReceiver  -Subject $MailSubjectError -Body $MailBodyError -BodyAsHtml -SmtpServer $MailSMTP -Port $MailSMTPPort -UseSsl -Credential $cred -Attachments $MailAttachment -encoding ([System.Text.Encoding]::UTF8)
                        Write-Host "Dont worry ..... dont know how to solve this message, but Mail is on the way!" -ForegroundColor green
                        Write-Host "if not.... Check please your settings!" -ForegroundColor green
                        Write-Host "back to Menu in 10 seconds......" -ForegroundColor white
                        sleep 10
                     }
           
                        B {$testObject = [pscustomobject]@{'MailSender' = $MailSender; 'MailReceiver' = $MailReceiver; 'MailSMTP' = $MailSMTP; 'MailSMTPPort' = $MailSMTPPort; 'MailSubjectError' = $MailSubjectError; 'MailBodyError' = $MailBodyError; 'countsForError' = $countsForError; 'ErrorReportOnOFF' = $ErrorReportOnOFF; 'timerForError' = $timerForError; 'MailSubjectReminder' = $MailSubjectReminder; 'MailBodyReminder' = $MailBodyReminder; 'ReminderTimer' = $ReminderTimer; 'ReminderOnOFF' = $ReminderOnOFF; 'MailSubjectReporter' = $MailSubjectReporter; 'MailBodyReporter' = $MailBodyReporter; 'ReportTimer' = $ReportTimer; 'ReportOnOff' = $ReportOnOff; 'MailSubjectAlert' = $MailSubjectAlert; 'MailBodyAlert' = $MailBodyAlert; 'AlertTimer' = $AlertTimer; 'AlertOnOff' = $AlertOnOff}
                           $testObject | Export-Csv -Path ./iniBackup.txt
                           Copy-Item -Path .\MailPW.txt -Destination .\MailPWBackup.txt
                        }

                             S {$testObject = [pscustomobject]@{'MailSender' = $MailSender; 'MailReceiver' = $MailReceiver; 'MailSMTP' = $MailSMTP; 'MailSMTPPort' = $MailSMTPPort; 'MailSubjectError' = $MailSubjectError; 'MailBodyError' = $MailBodyError; 'countsForError' = $countsForError; 'ErrorReportOnOFF' = $ErrorReportOnOFF; 'timerForError' = $timerForError; 'MailSubjectReminder' = $MailSubjectReminder; 'MailBodyReminder' = $MailBodyReminder; 'ReminderTimer' = $ReminderTimer; 'ReminderOnOFF' = $ReminderOnOFF; 'MailSubjectReporter' = $MailSubjectReporter; 'MailBodyReporter' = $MailBodyReporter; 'ReportTimer' = $ReportTimer; 'ReportOnOff' = $ReportOnOff; 'MailSubjectAlert' = $MailSubjectAlert; 'MailBodyAlert' = $MailBodyAlert; 'AlertTimer' = $AlertTimer; 'AlertOnOff' = $AlertOnOff}
                                $testObject | Export-Csv -Path ./ini.txt
                
                               }

                                R {$testObject = [pscustomobject]@{    }
                
                                Copy-Item -Path .\MailPW.txt -Destination .\MailPW.old.txt
                                remove-item -Path .\MailPW.txt
                                (Get-Credential).password | ConvertFrom-SecureString > .\MailPW.txt
                                 }
                                    Q {$testObject = [pscustomobject]@{   }
                                    exit
                                    }

default {}
}
  clear-Host
 
   
    # Mail Info
         Write-Host "============ Mail settings =============="
        Write-Host " 1: " -ForegroundColor white -NoNewline; Write-Host "MailSender: " -ForegroundColor red -NoNewline; Write-Host $MailSender
        Write-Host " 2: " -ForegroundColor white -NoNewline;Write-Host "MailReceiver: " -ForegroundColor red -NoNewline; Write-Host $MailReceiver
        Write-Host " 3: " -ForegroundColor white -NoNewline;Write-Host "MailSMTP: " -ForegroundColor red -NoNewline; Write-Host $MailSMTP
        Write-Host " 4: " -ForegroundColor white -NoNewline;Write-Host "MailSMTPPort: " -ForegroundColor red -NoNewline; Write-Host $MailSMTPPort
          # Error Setting
          Write-Host "============ Error Setting =============="
            Write-Host " 5: " -ForegroundColor white -NoNewline;Write-Host "MailSubjectError: " -ForegroundColor red -NoNewline; Write-Host $MailSubjectError
            Write-Host " 6: " -ForegroundColor white -NoNewline;Write-Host "MailBodyError: " -ForegroundColor red -NoNewline; Write-Host $MailBodyError
            Write-Host " 7: " -ForegroundColor white -NoNewline;Write-Host "CountsForError: " -ForegroundColor red -NoNewline; Write-Host $countsForError       
            Write-Host " 8: " -ForegroundColor white -NoNewline;Write-Host "TimerForError: " -ForegroundColor red -NoNewline; Write-Host $timerForError
            Write-Host " 9: " -ForegroundColor white -NoNewline;Write-Host "ErrorReportOnOFF: " -ForegroundColor red -NoNewline; Write-Host $ErrorReportOnOFF
            
                # Reminder Setting
                Write-Host "========== Reminder Setting ============="
                Write-Host "10: " -ForegroundColor white -NoNewline;Write-Host "MailSubjectReminder: " -ForegroundColor red -NoNewline; Write-Host $MailSubjectReminder
                Write-Host "11: " -ForegroundColor white -NoNewline;Write-Host "MailBodyReminder: " -ForegroundColor red -NoNewline; Write-Host $MailBodyReminder
                Write-Host "12: " -ForegroundColor white -NoNewline;Write-Host "ReminderTimer: " -ForegroundColor red -NoNewline; Write-Host $ReminderTimer
                Write-Host "13: " -ForegroundColor white -NoNewline;Write-Host "ReminderOnOFF: " -ForegroundColor red -NoNewline; Write-Host $ReminderOnOFF
                    # Reporter Setting 
                    Write-Host "========= Reporter Settings ============="
                    Write-Host "14: " -ForegroundColor white -NoNewline;Write-Host "MailSubjectReporter: " -ForegroundColor red -NoNewline; Write-Host $MailSubjectReporter
                    Write-Host "15: " -ForegroundColor white -NoNewline;Write-Host "MailBodyReporter: " -ForegroundColor red -NoNewline; Write-Host $MailBodyReporter
                    Write-Host "16: " -ForegroundColor white -NoNewline;Write-Host "ReportTimer: " -ForegroundColor red -NoNewline; Write-Host $ReportTimer
                    Write-Host "17: " -ForegroundColor white -NoNewline;Write-Host "ReportOnOff: " -ForegroundColor red -NoNewline; Write-Host $ReportOnOff
                        # Alert Setting
                        Write-Host "========= Reporter Settings ============="
                        Write-Host "18: " -ForegroundColor white -NoNewline;Write-Host "MailSubjectAlert: " -ForegroundColor red -NoNewline; Write-Host $MailSubjectAlert
                        Write-Host "19: " -ForegroundColor white -NoNewline;Write-Host "MailBodyAlert: " -ForegroundColor red -NoNewline; Write-Host $MailBodyAlert
                        Write-Host "20: " -ForegroundColor white -NoNewline;Write-Host "AlertTimer: " -ForegroundColor red -NoNewline; Write-Host $AlertTimer
                        Write-Host "21: " -ForegroundColor white -NoNewline;Write-Host "AlertOnOff: " -ForegroundColor red -NoNewline; Write-Host $AlertOnOff         
                            # rest
                            Write-Host "========================================="
                            Write-Host " T: " -ForegroundColor white -NoNewline;Write-Host "Test Email" -ForegroundColor red
                            Write-Host " B: " -ForegroundColor white -NoNewline;Write-Host "Backup the settings" -ForegroundColor red
                            Write-Host " S: " -ForegroundColor white -NoNewline;Write-Host "Save the settings" -ForegroundColor red
                            Write-Host " R: " -ForegroundColor white -NoNewline;Write-Host "Reset Mail Credential" -ForegroundColor red   
                            Write-Host "========================================="
                            Write-Host " Q: " -ForegroundColor white -NoNewline;Write-Host "Quit" -ForegroundColor red
                            Write-Host "========================================="
}

# writing changing menu variables to the ini.txt

$testObject = [pscustomobject]@{'MailSender' = $MailSender; 'MailReceiver' = $MailReceiver; 'MailSMTP' = $MailSMTP; 'MailSMTPPort' = $MailSMTPPort; 'MailSubjectError' = $MailSubjectError; 'MailBodyError' = $MailBodyError; 'countsForError' = $countsForError; 'ErrorReportOnOFF' = $ErrorReportOnOFF; 'timerForError' = $timerForError; 'MailSubjectReminder' = $MailSubjectReminder; 'MailBodyReminder' = $MailBodyReminder; 'ReminderTimer' = $ReminderTimer; 'ReminderOnOFF' = $ReminderOnOFF; 'MailSubjectReporter' = $MailSubjectReporter; 'MailBodyReporter' = $MailBodyReporter; 'ReportTimer' = $ReportTimer; 'ReportOnOff' = $ReportOnOff; 'MailSubjectAlert' = $MailSubjectAlert; 'MailBodyAlert' = $MailBodyAlert; 'AlertTimer' = $AlertTimer; 'AlertOnOff' = $AlertOnOff}
$testObject | Export-Csv -Path ./ini.txt



 Write-Host "Error Reporter, Scheduler and Reporter starts now depending of your setting on/off " -ForegroundColor white
 Write-Host "you can also start them seperatly over the ps1 files in your folder (if you using windows shedule ae)" -ForegroundColor white
Write-Host "all changes are saved to start Error-Messager, Reporter or Schedule use the Script for it.Setting get importet from here" -ForegroundColor white
echo ""
echo ""

if ($ErrorReportOnOFF -eq "on") {$host.UI.RawUI.WindowTitle = "Start Fenster";
invoke-expression 'cmd /c start pwsh.exe -NoExit -Command {                           `
    .\MN-ErrorReport.ps1                  `
                                                              `
}'
}
if ($ReportOnOff -eq "on"){$host.UI.RawUI.WindowTitle = "Start Fenster";
invoke-expression 'cmd /c start pwsh.exe -NoExit -Command {                           `
    .\MN-Reporter.ps1                `
                                                              `
}'
}
if ($ReminderOnOFF -eq "on"){$host.UI.RawUI.WindowTitle = "Start Fenster";
invoke-expression 'cmd /c start pwsh.exe -NoExit -Command {                           `
    .\MN-Scheduler.ps1                 `
                                                              `
}'
}

if ($AlertOnOff -eq "on"){$host.UI.RawUI.WindowTitle = "Start Fenster";
invoke-expression 'cmd /c start pwsh.exe -NoExit -Command {                           `
    .\MN-Alert.ps1                 `
                                                              `
}'
}


