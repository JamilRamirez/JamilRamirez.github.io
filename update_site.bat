@echo off
cd /d E:\JAMIL\Blog\jamil-blog

echo.
echo === Render Quarto site ===
quarto render
if errorlevel 1 goto error

echo.
echo === Add changes ===
git add -A
if errorlevel 1 goto error

echo.
echo === Commit changes if needed ===
git diff --cached --quiet
set DIFF_EXIT=%ERRORLEVEL%

if "%DIFF_EXIT%"=="0" (
    echo No changes to commit.
) else if "%DIFF_EXIT%"=="1" (
    git commit -m "Website update"
    if errorlevel 1 goto error
) else (
    goto error
)

echo.
echo === Pull latest changes ===
git pull --rebase origin main
if errorlevel 1 goto error

echo.
echo === Push source files to GitHub ===
git push origin main
if errorlevel 1 goto error

echo.
echo === Publish site to gh-pages ===
quarto publish gh-pages --no-prompt
if errorlevel 1 goto error

echo.
echo === Opening website ===
timeout /t 8 /nobreak >nul
start "" "https://jamilramirez.github.io/?refresh=%RANDOM%"

echo.
echo Done.
pause
exit /b 0

:error
echo.
echo ERROR: Something failed. Check the messages above.
pause
exit /b 1