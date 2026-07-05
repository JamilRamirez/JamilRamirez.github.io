@echo off
cd /d E:\JAMIL\Blog\jamil-blog
git pull --rebase origin main
quarto render
git add .
git status
git commit -m "Website update"
git push
pause