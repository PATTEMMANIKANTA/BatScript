@ECHO OFF
sc query Adeptaccelerator.Apiservice$AdeptAccelerator.API.DevSSO | findstr RUNNING
if %errorlevel% == 0 (
echo "Errorlevel: %errorlevel%"
echo "Service running successfully." 
echo "Archiving Old Code"
7za.exe a C:\\AdminTasks\\Backups\\INav_Dev_Api_%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip "C:\\Deployment\\WinService\\AdeptAccelerator\\Dev\\*"
echo "Archived Old Code"
attrib -r "C:\\Deployment\\WinService\\AdeptAccelerator\\Dev\\*.*" /s
echo "******STOP Adeptaccelerator.Apiservice$AdeptAccelerator.API.DevSSO SERVICE*******"
SC STOP Adeptaccelerator.Apiservice$AdeptAccelerator.API.DevSSO
ping 127.0.0.1 -n 20
7za.exe x C:\\temp\\tmp\\INav_Dev_Api_tmp_%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip -oC:\\Deployment\\WinService\\AdeptAccelerator\\Dev\\ -y -r
echo "******START Adeptaccelerator.Apiservice$AdeptAccelerator.API.DevSSO SERVICE*******"
SC START Adeptaccelerator.Apiservice$AdeptAccelerator.API.DevSSO
ping 127.0.0.1 -n 20
echo "******STARTED Adeptaccelerator.Apiservice$AdeptAccelerator.API.DevSSO SERVICE*******"
)
sc query Adeptaccelerator.Apiservice$AdeptAccelerator.API.DevSSO | findstr RUNNING
if %errorlevel% == 1 (
echo "Errorlevel: %errorlevel%"
echo "Service in stopped state." 
echo "Archiving Old Code"
7za.exe a C:\\AdminTasks\\Backups\\INav_Dev_Api_%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip "C:\\Deployment\\WinService\\AdeptAccelerator\\Dev\\*"
echo "Archived Old Code"
attrib -r "C:\\Deployment\\WinService\\AdeptAccelerator\\Dev\\*.*" /s
7za.exe x C:\\temp\\tmp\\INav_Dev_Api_tmp_%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip -oC:\\Deployment\\WinService\\AdeptAccelerator\\Dev\\ -y -r
echo "******START Adeptaccelerator.Apiservice$AdeptAccelerator.API.DevSSO SERVICE*******"
SC START Adeptaccelerator.Apiservice$AdeptAccelerator.API.DevSSO
echo "******STARTED Adeptaccelerator.Apiservice$AdeptAccelerator.API.DevSSO SERVICE*******"
)