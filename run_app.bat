@echo off
REM Launcher script for Tracer Tools (Windows)

echo Starting Tracer Tools...
echo.

REM Check if R is installed in PATH
where Rscript >nul 2>nul
if %errorlevel% equ 0 (
    set "RSCRIPT_PATH=Rscript"
    goto :run_app
)

REM R not in PATH - check if config file exists
if exist "r_path.txt" (
    set /p RSCRIPT_PATH=<r_path.txt
    if exist "%RSCRIPT_PATH%" (
        echo Using R from: %RSCRIPT_PATH%
        goto :run_app
    )
)

REM R not found - ask user for path
echo R is not found in PATH.
echo.
echo Please provide the full path to Rscript.exe
echo Common locations:
echo   C:\Program Files\R\R-4.x.x\bin\Rscript.exe
echo   C:\Program Files\R\R-4.x.x\bin\x64\Rscript.exe
echo.
set /p "RSCRIPT_PATH=Enter full path to Rscript.exe: "

REM Validate the path
if not exist "%RSCRIPT_PATH%" (
    echo.
    echo ERROR: File not found: %RSCRIPT_PATH%
    echo Please install R from https://cran.r-project.org/
    echo.
    pause
    exit /b 1
)

REM Save the path for future use
echo %RSCRIPT_PATH%>r_path.txt
echo.
echo Path saved to r_path.txt for future use.
echo.

:run_app
REM Run the Shiny app
echo Opening Tracer Tools in your browser...
"%RSCRIPT_PATH%" -e "shiny::runApp('app.R', launch.browser = TRUE)"

pause
