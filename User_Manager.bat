@echo off

Title User Manager

:Main

cls
echo ------------USER MANAGER------------
echo.
echo 1. Account Details
echo.
echo 2. List Administrators
echo.
echo 3. List Users
echo.
echo 4. Give Administrator Privilege
echo.
echo 5. Revoke Administrator Privilege
echo.
echo 6. Enable Account (Allows users to log on)
echo.
echo 7. Disable Account (Prevents users from logging on)
echo.
echo 8. Change Password
echo.
echo 9. Create Account
echo.
echo 10. Delete Account
echo.
echo 11. Quit
echo.
echo Make sure you're an Admin before using this script.
echo.
set /p "option=Choose the number of your action: "
echo %option%
if %option% == 1 goto :details
if %option% == 2 goto :list_Admins
if %option% == 3 goto :list_Users
if %option% == 4 goto :giveAdmin
if %option% == 5 goto :revAdmin
if %option% == 6 goto :enableAcc
if %option% == 7 goto :disableAcc
if %option% == 8 goto :changePass
if %option% == 9 goto :createAcc
if %option% == 10 goto :delete
if %option% == 11 goto :eof
goto :Main

:details
cls
echo ------------Account Details------------
echo.
net user
set /p "account=Enter the name of the account for more details, or type [b] to go back: "
if %account% == b goto :Main
cls
echo ------------%account%------------
net user %account%
if %errorlevel% NEQ 0 goto :details
pause
goto :details


:list_Admins
cls
echo ------------Administrators------------
echo.
net localgroup Administrators
pause
goto :Main

:list_Users
cls
echo ------------ALL USERS------------
echo.
net user
pause
goto :Main

:giveAdmin
cls
echo ------------GIVE ADMINISTRATOR PRIVILEGE------------
echo.
echo LIST OF ALL USERS
echo -----------------
net user
echo.
echo LIST OF ADMINS
echo --------------
net localgroup administrators
echo.
set /p "upgrade=Which user should get administrator privilege, or type [b] to go back: "
if %upgrade% == b goto :Main
net localgroup administrators %upgrade% /add
if %errorlevel% NEQ 0 goto :giveAdmin
echo Success!
pause
goto :giveAdmin

:revAdmin
cls
echo ------------REVOKE ADMINISTRATOR PRIVILEGE------------
echo.
echo LIST OF ADMINS
echo --------------
net localgroup administrators
echo.
set /p "downgrade=Which user should lose administrator privilege, or type [b] to go back: "
if %downgrade% == b goto :Main
net localgroup administrators %downgrade% /delete
if %errorlevel% NEQ 0 goto :revAdmin
echo Success!
pause
goto :revAdmin

:enableAcc
cls
echo ------------ENABLE ACCOUNT------------
echo.
echo LIST OF ALL USERS
echo -----------------
net user
echo.
set /p "toEnable=Which account should be enabled, or type [b] to go back: "
if %toEnable% == b goto :Main
net user %toEnable% /active:yes
if %errorlevel% NEQ 0 goto :enableAcc
echo Success!
pause
goto :enableAcc

:disableAcc
cls
echo ------------DISABLE ACCOUNT------------
echo.
echo LIST OF ALL USERS
echo -----------------
net user
echo.
set /p "toDisable=Which account should be Disabled, or type [b] to go back: "
if %toDisable% == b goto :Main
net user %toDisable% /active:no
if %errorlevel% NEQ 0 goto :disableAcc
echo Success!
pause
goto :disableAcc

:changePass
cls
echo ------------CHANGE PASSWORD------------
echo.
echo LIST OF ALL USERS
echo -----------------
net user
echo.
set /p "userEdit=Whose password should be changed, or type [b] to go back: "
if %userEdit% == b goto :Main
set /p "newPass=What should the new password be, or type [b] to go back: "
if %newPass% == b goto :Main
net user %userEdit% %newPass%
if %errorlevel% NEQ 0 goto :changePass
echo Success!
pause
goto :changePass

:createAcc
cls
echo ------------CREATE ACCOUNT------------
echo.
echo LIST OF ALL USERS
echo -----------------
net user
echo.
set /p "newName=Enter the name of the new account, or type [b] to go back: "
if %newName% == b goto :Main
set /p "freshPass=Enter the password, or type [b] to go back: "
if %freshPass% == b goto :Main
net user %newName% %freshPass% /add
if %errorlevel% NEQ 0 goto :createAcc
echo Success!
pause
goto :createAcc

:delete
cls
echo ------------DELETE ACCOUNT------------
echo.
echo LIST OF ALL USERS
echo -----------------
net user
echo.
set /p "toDelete=Which account should be deleted, or type [b] to go back: "
if %toDelete% == b goto :Main
set /p "confirm=Are you absolutely certain? [y/n]: "
if %confirm% == n goto :Main
net user %toDelete% /DELETE
if %errorlevel% NEQ 0 goto :delete
echo Success!
pause
goto :delete