#!/bin/bash

# git commands to merge into main the stacked branches created in part1

## feature_a is landed, and we're currently on feature_b
#
git checkout main
git fetch
git merge origin/main

# clean up merged feature_a
git branch -d feature_a
git push origin :feature_a


git checkout feature_b  #(before was feature_a)
# squash commits to reduce number of merge concficts
git reset <sha1 of last commit to feature_a>
git add my_file.txt
git commit -m"feature_b commit squash"

git rebase -i main   # drop feature_a commits, drop earlier commits reduce merge conflicts


#  push feature_b to create PR
git push -u origin feature_b
