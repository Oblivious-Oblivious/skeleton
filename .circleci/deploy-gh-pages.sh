#!/bin/sh

[ ! -z "Oblivious-Oblivious" ] && git config user.name "Oblivious-Oblivious"
[ ! -z "me262thanos@gmail.com" ] && git config user.email "me262thanos@gmail.com"

MAIN_BRANCH=$(git symbolic-ref --short HEAD)
DIST="${1:-dist}";

git stash
git branch --delete --force gh-pages
git checkout --orphan gh-pages
git add -f $DIST
git commit -m "Rebuild GitHub pages [ci skip]"
git filter-branch -f --prune-empty --subdirectory-filter $DIST && git push -f origin gh-pages
git checkout $MAIN_BRANCH
git stash apply || :
