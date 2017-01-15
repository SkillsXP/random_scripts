@echo off

REM run bat file as administrator

goto comment

This batch script will do the following tasks: 

-disable guest account 
-enable firewall
-enable auto-update
-require ctrl+alt+del at logon
-stop telnet service
-update password policy
-update account lockout policy

:comment 

title Basic Settings

REM disables guest account
net user guest /active:no

REM enables firewall on all networks (i.e. private, guest, and public networks)
netsh advfirewall set allprofiles state on

REM enables automatic updates... Careful! Editing registry keys can be dangerous if done wrong!
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 4 /f

REM enables ctr+alt+del... Careful! Editing registry keys can be dangerous if done wrong!
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DisableCAD /t REG_DWORD /d 0 /f

REM stops telnet service
net stop telnet

goto ifdisabletelnet

If you want to disable telnet compeletly instead of just stopping it, run
sc config tlntsvr start disabled

:ifdisabletelnet

REM update password policy requirements-- does NOT enable omplexity requirements!!!!!
net accounts /minpwlen:14
net accounts /maxpwage:30
net accounts /minpwage:10
net accounts /uniquepw:24

REM update account lockout policy
net accounts /lockoutduration:30
net accounts /lockoutthreshold:3
net accounts /lockoutwindow:30

pause