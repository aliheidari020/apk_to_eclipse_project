set APKFILE=%1
set PROJECTFOLDER=%2

rmdir /Q /S apktool-files
rmdir /Q /S dex2jar-2.0
rmdir /Q /S jd-cli-0.9.1.Final-dist
del /Q /S classes.jar
rmdir /Q /S %PROJECTFOLDER%

unzip apktool-files.zip -d apktool-files
unzip jd-cli-0.9.1.Final-dist.zip -d jd-cli-0.9.1.Final-dist
unzip dex2jar-2.0.zip


call .\apktool-files\apktool.bat d %APKFILE% -o %PROJECTFOLDER%
rmdir /Q /S %PROJECTFOLDER%\original
rmdir /Q /S %PROJECTFOLDER%\smali
del /Q /S %PROJECTFOLDER%\apktool.yml

call dex2jar-2.0\d2j-dex2jar.bat -f -o classes.jar %APKFILE%
call .\jd-cli-0.9.1.Final-dist\jd-cli.bat classes.jar -od %PROJECTFOLDER%\src
rmdir /Q /S %PROJECTFOLDER%\src\android
cd %PROJECTFOLDER%\src
del /Q /S BuildConfig.java
del /Q /S R.java
del /Q /S R$*.java
cd ..
cd ..


rem	**************************************CLEAN UP*******************************************
rmdir /Q /S apktool-files
rmdir /Q /S dex2jar-2.0
rmdir /Q /S jd-cli-0.9.1.Final-dist
del /Q /S classes.jar