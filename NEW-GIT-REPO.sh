#!/bin/bash

read -p "Repo Link (HTTPS): " repolink

echo "Creating local repo and pushing files to remote repo"

git init
git add *
git commit -m "first commit"
git branch -M main
git remote add origin $repolink
git push -u origin main

echo "Finished"
echo "Press ENTER to exit"
read junk
