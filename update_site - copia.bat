git pull --rebase origin main
quarto render
git add .
git commit -m "Website update"
git push
quarto publish gh-pages
pause