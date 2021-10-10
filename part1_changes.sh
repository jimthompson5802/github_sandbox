#!/bin/bash
set -xe

# bash script to setup up two "stacked" PR to test out git commands

# set initial starting point
#git checkout main

# assume we're starting on main
git checkout -b feature_a  origin/main # do some work on a new branch
                                       # works on both main and origin/main
cat <<EOF >> my_file.txt
feature_a line 1 commit 1
feature_a line 2 commit 1
EOF
git add my_file.txt
git commit -m"feature_a commit 1"

cat <<EOF >>my_file.txt
feature_a line3 commit 2
feature_a line4 commit 2
EOF
git add my_file.txt
git commit -m"feature_a commit 2"


git push -u origin feature_a # feature_a is in review, want to keep going

# now perform additional work
git checkout -b feature_b  # do some work on feature_b as a continuation while we wait

sed -i '' -e '4s/$/ feature_b line 2 commit 1/' my_file.txt
git add my_file.txt
git commit -m"feature_b commit 1"

sed -i '' -e '6s/$/ feature_b line 4 commit 2/' my_file.txt
git add my_file.txt
git commit -m"feature_b commit 2"

cat <<EOF >> my_file.txt
feature_b line 3 commit 3
feature_b line 4 commit 3
EOF
git add my_file.txt
git commit -m"feature_b commit 3"

# go back to feature_a
git checkout feature_a
sed -i '' -e '6s/$/ feature_a line 4 post feature_b/' my_file.txt
sed -i '' -e '6a\'$'\n''feature_a line 4.1 post feature_b' my_file.txt
git add my_file.txt
git commit -m"feature_a changes after feature_b branch"
git push -u origin feature_a

# go back to feature_b
git checkout feature_b
sed -i '' -e '7a\'$'\n''feature_b line 3.1 commit 4' my_file.txt
git add my_file.txt
git commit -m"feature_b commit 4"
