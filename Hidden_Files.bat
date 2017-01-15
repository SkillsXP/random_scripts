title Show Hidden Files

REM shows hidden files ofc
dir c:\WIDNOWS\system32 /A:H /B /S

goto comment

If you want to see all hidden files on this machine, run
dir c:\WINDOWS /A:H /B /S

If you want to see only the hidden files stored directly in the system32 folder, run
dir c:\WINDOWS /A:H /B

:comment

pause