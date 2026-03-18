@echo off
REM Launcher script for Tracer Tools (Windows)

echo Starting Tracer Tools...
echo.

REM Check if R is installed
where Rscript >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: R is not installed or not in PATH.
    echo Please install R from https://cran.r-project.org/
    echo.
    pause
    exit /b 1
)

REM Run the Shiny app
echo Opening Tracer Tools in your browser...
Rscript -e "shiny::runApp('app.R', launch.browser = TRUE)"

pause
