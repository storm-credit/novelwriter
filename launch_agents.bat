@echo off
SET PATH=C:\Program Files\nodejs;C:\Users\Raino PI\AppData\Roaming\npm;%PATH%
cd /d C:\novel\novelwriter

echo ============================================
echo  novelwriter 3-Division Agent Launcher
echo ============================================
echo.
echo 1. Story Program Manager (PM)
echo 2. Design Manager (설계군)
echo 3. Writing Manager (집필군)
echo 4. Audit Manager (감리군)
echo 5. 전체 4개 동시 실행
echo.
set /p choice=선택 (1-5):

if "%choice%"=="1" start "PM" cmd /k "SET PATH=C:\Program Files\nodejs;C:\Users\Raino PI\AppData\Roaming\npm;%PATH% && cd /d C:\novel\novelwriter && claude"
if "%choice%"=="2" start "Design" cmd /k "SET PATH=C:\Program Files\nodejs;C:\Users\Raino PI\AppData\Roaming\npm;%PATH% && cd /d C:\novel\novelwriter && claude"
if "%choice%"=="3" start "Writing" cmd /k "SET PATH=C:\Program Files\nodejs;C:\Users\Raino PI\AppData\Roaming\npm;%PATH% && cd /d C:\novel\novelwriter && claude"
if "%choice%"=="4" start "Audit" cmd /k "SET PATH=C:\Program Files\nodejs;C:\Users\Raino PI\AppData\Roaming\npm;%PATH% && cd /d C:\novel\novelwriter && claude"
if "%choice%"=="5" (
    start "PM" cmd /k "SET PATH=C:\Program Files\nodejs;C:\Users\Raino PI\AppData\Roaming\npm;%PATH% && cd /d C:\novel\novelwriter && claude"
    timeout /t 2 /nobreak >nul
    start "Design Manager" cmd /k "SET PATH=C:\Program Files\nodejs;C:\Users\Raino PI\AppData\Roaming\npm;%PATH% && cd /d C:\novel\novelwriter && claude"
    timeout /t 2 /nobreak >nul
    start "Writing Manager" cmd /k "SET PATH=C:\Program Files\nodejs;C:\Users\Raino PI\AppData\Roaming\npm;%PATH% && cd /d C:\novel\novelwriter && claude"
    timeout /t 2 /nobreak >nul
    start "Audit Manager" cmd /k "SET PATH=C:\Program Files\nodejs;C:\Users\Raino PI\AppData\Roaming\npm;%PATH% && cd /d C:\novel\novelwriter && claude"
)
