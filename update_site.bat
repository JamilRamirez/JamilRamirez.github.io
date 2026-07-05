@echo off
cd /d E:\JAMIL\Blog\jamil-blog

echo.
echo === Render Quarto site ===
quarto render
if errorlevel 1 goto error

echo.
echo === Add changes ===
git add .
if errorlevel 1 goto error

echo.
echo === Commit changes if needed ===
git diff --cached --quiet
if %errorlevel%==0 (
    echo No changes to commit.
) else (
    git commit -m "Website update"
    if errorlevel 1 goto error
)

echo.
echo === Pull latest changes ===
git pull --rebase origin main
if errorlevel 1 goto error

echo.
echo === Push to GitHub ===
git push
if errorlevel 1 goto error

echo.
echo Done.
pause
exit /b 0

:error
echo.
echo ERROR: Something failed. Check the messages above.
pause
exit /b 1

echo.
echo === Publish site to gh-pages ===
quarto publish gh-pages
if errorlevel 1 goto error