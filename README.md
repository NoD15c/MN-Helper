# MN-Helper
Reporting for Mastermodes - powershell -> for working you need Strax based Masternode

This Scrip is looking at your MN if you are Mining or not, it send you a Email on missed Mining over time. 2 diverent timeshedules vor "still alive Message" and a "Backup/Update" reminder.
Also a Alert Mail on Remotelogon is possible. ->> atm not working on all systems

please be considerate. my programming skills are somewhat similar to my knowledge of English just starting


feel free to make a donate to this Strax Adress:
XVQqFEWJ2YbbccD4RLpuXTf8kqjvZPLdwe


 is not digitally signed message :
 Its needed to Unblock the file by right clicking on the zip. And ticking the unblock checkbox.
 thnx to powderblock he commented on 12 Aug 2020![image](https://user-images.githubusercontent.com/94227500/141652831-1d3e86b2-f0a3-4300-a6d6-48fd03e9c135.png)
 
 
 
 
 
# Setup:
Make a new folder on your desktop ( any name )
Put the files frome the MN-Helper folder  in it. (Current MN-Helper-Setup.ps1, MN-ErrorReport.ps1, MN-Reporter.ps1, MN-Scheduler.ps1, MN-Alert.ps1)
Open your powershell and navigate to this new folder and start the MN-Helper-Setup.ps1 file
This Setup will save a ini.txt file and mailpw.txt and maybee a backupfile of them if you choise it, in the folder. This files are needed fort the other .ps1 scripts.
 They load the variables over it.The ini and pw file will needed to hold the settings on a restart oft he scripts.
In the first steps on mail account setting it needs to create a credential Username/pw from the Mailaccount. 
It will be save as a Securestring and will work only on the same Computer you created it.
You can setup a new Email account (i use gmx)

Explain the Parameters:
# Mail Setting
MailSender = the email adress of your sender account ( sender@gmx.de )
MailReceiver = the mail adress of the mail receiver (receiver@gmx.de / your email adress)
Mailsmtp = smtp of your mail provider (mail.gmx.net)
SMTP Port = (ist ssl) the port for your mail provider  (587)

# Error Setting 
SubjectErroR = which message show in your Error Email 
BodyError = Free Text show in your Error Email
Counts for Error = how many errors happend before send a mail, counter reset on next good status to 0. 
Atm a security setting is fix in Line 62 in MN-ErrorReport.ps1 (counts 60 Mails and end the program, spam protect if a error happend)
TimerForError = set the breaktime between the status checks , in Minutes     

ErrorReportOnOFF = switch for on or  / off


# Reminder Setting
MailSubjectReminder = which message show in your Reminder Email 
MailBodyReminder = Free Text show in your Reminder Email
ReminderTimer = Time in hour for next sending the reminder Email

ReminderOnOFF = switch for on or  / off


# Reporter Setting (i am Alive message)

MailSubjectReporter = which message show in your ReportEmail 
MailBodyReporter = Free Text show in your ReportEmail
ReportTimer = Time in hour for next sending the reminder Email
ReportOnOff = switch for on or  / off

# Login Alert Setting 
 
MailSubjectAlert = which message show in your AlertEmail
MailBodyAlert = Free Text show in your AlertEmail
AlertTimer = Time in secounds for next check of logon status
AlertOnOff $ReminderOnOFF = switch for on or  / off

the scrips:
MN-Helper-Setup.ps1 - only for setup the needed variables , it will be saved in the ini.txt .the other scrips take the ini.txt file to fill there varibles
MN-ErrorReport.ps1 - send you a mail if the Mining not works.whit existing and filled ini.txt the srcipt can start seperatly whitout each other
MN-Reporter.ps1 - send you a mail every tiem you setup (i am alive). whit existing and filled ini.txt the srcipt can start seperatly whitout each other

not 100% finisht is:
MN-Scheduler.ps1 - send you a mail every tiem you setup (Scheduler for BackUp or Updates). whit existing and filled ini.txt the srcipt can start seperatly whitout each other
MN-Alert.ps1 - send you a email if soemone logon per remotesession. whit existing and filled ini.txt the srcipt can start seperatly whitout each other
