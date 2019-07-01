@ECHO OFF
sc query Adeptaccelerator.Apiservice$AdeptAccelerator.API.Service.QASSO | findstr RUNNING
if %errorlevel% == 0 (
echo "Errorlevel: %errorlevel%"
echo "Service running successfully." 
echo "Archiving Old Code"
7za.exe a C:\\AdminTasks\\Backups\\INav_QA_Api_%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip "C:\\Deployment\\WinService\\AdeptAccelerator\\QA\\*"
echo "Archived Old Code"
attrib -r "C:\Deployment\WinService\AdeptAccelerator\QA\*.*" /s
echo "******STOP Adeptaccelerator.Apiservice$AdeptAccelerator.API.Service.QASSO SERVICE*******"
SC STOP Adeptaccelerator.Apiservice$AdeptAccelerator.API.Service.QASSO
ping 127.0.0.1 -n 20
7za.exe x C:\\temp\\tmp\\INav_QA_Api_tmp_%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip -oC:\Deployment\WinService\AdeptAccelerator\QA -y -r
echo "******START Adeptaccelerator.Apiservice$AdeptAccelerator.API.Service.QASSO SERVICE*******"
SC START Adeptaccelerator.Apiservice$AdeptAccelerator.API.Service.QASSO
ping 127.0.0.1 -n 20
echo "******STARTED Adeptaccelerator.Apiservice$AdeptAccelerator.API.Service.QASSO SERVICE*******"
)
sc query Adeptaccelerator.Apiservice$AdeptAccelerator.API.Service.QASSO | findstr RUNNING
if %errorlevel% == 1 (
echo "Errorlevel: %errorlevel%"
echo "Service in stopped state." 
echo "Archiving Old Code"
7za.exe a C:\\AdminTasks\\Backups\\INav_QA_Api_%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip "C:\\Deployment\WinService\AdeptAccelerator\QA\*"
echo "Archived Old Code"
attrib -r "C:\Deployment\WinService\AdeptAccelerator\QA\*.*" /s
7za.exe x C:\\temp\\tmp\\INav_QA_Api_tmp_%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip -oC:\Deployment\WinService\AdeptAccelerator\QA -y -r
echo "******START Adeptaccelerator.Apiservice$AdeptAccelerator.API.Service.QASSO SERVICE*******"
SC START Adeptaccelerator.Apiservice$AdeptAccelerator.API.Service.QASSO
echo "******STARTED Adeptaccelerator.Apiservice$AdeptAccelerator.API.Service.QASSO SERVICE*******"
)