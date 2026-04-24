@echo off
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0"

title Olfe iDRAC6 Virtual Console Launcher

echo ==================================================
echo   Olfe Veri Merkezi A.S. - iDRAC6 KVM Launcher
echo ==================================================
echo.

set /P drachost="iDRAC Host/IP: "
set /P dracuser="Username: "

echo.
set "psCommand=powershell -NoProfile -Command "$pword = Read-Host 'Password' -AsSecureString; $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set "dracpwd=%%p"

echo.
echo [1/6] Java kontrol ediliyor...
where java >nul 2>&1
if errorlevel 1 (
    echo [HATA] Java bulunamadi.
    echo Lutfen Java 8 kurun. iDRAC6 icin Java 8 onerilir.
    pause
    exit /b 1
)

for /f "delims=" %%j in ('where java') do (
    set "JAVAEXE=%%j"
    goto :java_found
)

:java_found
echo Java yolu: !JAVAEXE!
java -version 2>&1

echo.
echo [2/6] Java mimarisi tespit ediliyor...
java -version 2>&1 | findstr /i "64-Bit" >nul
if errorlevel 1 (
    set "ARCH=Win32"
    echo Java mimarisi: 32-bit
) else (
    set "ARCH=Win64"
    echo Java mimarisi: 64-bit
)

echo.
echo [3/6] Gerekli klasorler hazirlaniyor...
if not exist "lib" mkdir "lib"

echo.
echo [4/6] avctKVM.jar kontrol ediliyor...
if not exist "avctKVM.jar" (
    echo avctKVM.jar indiriliyor...
    powershell -NoProfile -Command ^
    "[System.Net.ServicePointManager]::ServerCertificateValidationCallback={$true};" ^
    "$wc=New-Object Net.WebClient;" ^
    "$wc.DownloadFile('https://%drachost%/software/avctKVM.jar','avctKVM.jar')"

    if not exist "avctKVM.jar" (
        echo [HATA] avctKVM.jar indirilemedi.
        pause
        exit /b 1
    )
) else (
    echo avctKVM.jar mevcut.
)

echo.
echo [5/6] Native library kontrol ediliyor...
echo Secilen paket: %ARCH%

if not exist ".\lib\avmWinLib.dll" (
    echo avctVM%ARCH%.jar indiriliyor...
    powershell -NoProfile -Command ^
    "[System.Net.ServicePointManager]::ServerCertificateValidationCallback={$true};" ^
    "$wc=New-Object Net.WebClient;" ^
    "$wc.DownloadFile('https://%drachost%/software/avctVM%ARCH%.jar','.\lib\avctVM%ARCH%.zip')"

    if exist ".\lib\avctVM%ARCH%.zip" (
        powershell -NoProfile -Command "Expand-Archive '.\lib\avctVM%ARCH%.zip' -DestinationPath '.\lib' -Force"
        del ".\lib\avctVM%ARCH%.zip" /q
    ) else (
        echo [UYARI] avctVM%ARCH%.jar indirilemedi.
    )
) else (
    echo avmWinLib.dll mevcut.
)

if not exist ".\lib\avctKVMIO.dll" (
    echo avctKVMIO%ARCH%.jar indiriliyor...
    powershell -NoProfile -Command ^
    "[System.Net.ServicePointManager]::ServerCertificateValidationCallback={$true};" ^
    "$wc=New-Object Net.WebClient;" ^
    "$wc.DownloadFile('https://%drachost%/software/avctKVMIO%ARCH%.jar','.\lib\avctKVMIO%ARCH%.zip')"

    if exist ".\lib\avctKVMIO%ARCH%.zip" (
        powershell -NoProfile -Command "Expand-Archive '.\lib\avctKVMIO%ARCH%.zip' -DestinationPath '.\lib' -Force"
        del ".\lib\avctKVMIO%ARCH%.zip" /q
    ) else (
        echo [UYARI] avctKVMIO%ARCH%.jar indirilemedi.
    )
) else (
    echo avctKVMIO.dll mevcut.
)

if exist ".\lib\META-INF" rmdir ".\lib\META-INF" /s /q

echo.
echo [6/6] Baglanti baslatiliyor...
echo --------------------------------------------------
echo Host: %drachost%
echo User: %dracuser%
echo KVM Port: 5900
echo Virtual Media Port: 5900
echo Java: !JAVAEXE!
echo Native Lib Path: %CD%\lib
echo --------------------------------------------------
echo.

java -cp "avctKVM.jar" -Djava.library.path="%CD%\lib" com.avocent.idrac.kvm.Main ^
ip=%drachost% ^
kmport=5900 ^
vport=5900 ^
user=%dracuser% ^
passwd=%dracpwd% ^
apcp=1 ^
version=2 ^
vmprivilege=true ^
"helpurl=https://%drachost%:443/help/contents.html" ^
2>&1

echo.
echo --------------------------------------------------
echo Java cikis kodu: %ERRORLEVEL%
echo.

if %ERRORLEVEL% NEQ 0 (
    echo [DEBUG NOTLARI]
    echo - Java 8 kullanmaniz onerilir.
    echo - iDRAC6 Virtual Console icin TCP 5900 acik olmalidir.
    echo - Virtual Media hatasi varsa Java 32/64-bit ile indirilen native DLL mimarisi uyusmuyor olabilir.
    echo - Gerekirse lib klasorunu silip tekrar deneyin.
    echo - iDRAC tarafinda Virtual Console Enabled ve Virtual Media Attach/Auto Attach olmali.
)

pause
endlocal
