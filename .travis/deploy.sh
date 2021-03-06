#!/bin/bash
set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not the master! No deploy!"
  exit 0
fi
# build
npm run compile

# deploy
rev=$(git rev-parse --short HEAD)

cd demo/dist

git init
git config user.name "Travis Bot"
git config user.email $USER_EMAIL

git remote add upstream "https://$GH_TOKEN@github.com/LouisBarranqueiro/reapop.git"
git fetch upstream
git reset upstream/gh-pages

touch .

git add -A .
git commit -m "rebuild pages at ${rev}"
git push -q upstream HEAD:gh-pages