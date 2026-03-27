@echo off

set TOOLS=tools
set SRC=src
set OUT=out

if exist %OUT% rmdir /s /q %OUT%
mkdir %OUT%

:: ── Read version early ───────────────────────────────────────────
for /f "tokens=2 delims==" %%A in ('findstr "^version=" module\module.prop') do set VERSION=%%A
echo Version: %VERSION%

echo [1/4] Compiling...
%TOOLS%\aapt2.exe compile --dir %SRC%\res -o %OUT%\compiled.flata
if errorlevel 1 goto error

echo [2/4] Linking...
%TOOLS%\aapt2.exe link ^
    --manifest %SRC%\AndroidManifest.xml ^
    -I %TOOLS%\framework-res.apk ^
    -o %OUT%\unaligned.apk ^
    %OUT%\compiled.flata
if errorlevel 1 goto error
del %OUT%\compiled.flata

echo [3/4] Zipaligning...
%TOOLS%\zipalign.exe -p 4 %OUT%\unaligned.apk %OUT%\aligned.apk
if errorlevel 1 goto error
del %OUT%\unaligned.apk

echo [4/4] Signing...
java -jar %TOOLS%\apksigner.jar sign ^
    --ks %TOOLS%\debug.keystore ^
    --ks-pass pass:android ^
    --out %OUT%\CursorOverlay.apk ^
    %OUT%\aligned.apk
if errorlevel 1 goto error
del %OUT%\aligned.apk
del %OUT%\CursorOverlay.apk.idsig 2>nul

echo.
echo Verifying...
java -jar %TOOLS%\apksigner.jar verify -v %OUT%\CursorOverlay.apk

echo.
echo Copying APK into module...
if not exist module\system\product\overlay mkdir module\system\product\overlay
copy /Y %OUT%\CursorOverlay.apk module\system\product\overlay\CursorOverlay.apk
if errorlevel 1 goto error
del %OUT%\CursorOverlay.apk

:: ── Package module zip ───────────────────────────────────────────
echo.
echo Packaging SPenCursorOverlay-%VERSION%.zip...
tools\7z.exe a -tzip -mx=9 "out\SPenCursorOverlay-%VERSION%.zip" ".\module\*"
if errorlevel 1 goto error

echo.
echo ================================================
echo  Build Complete!
echo  Module: out\SPenCursorOverlay-%VERSION%.zip
echo ================================================
goto end

:error
echo.
echo [ERROR] Build failed. See output above.
exit /b 1

:end