set -e

npm run docs:build

 cd .\src\.vuepress\dist\

git init


git add -A

git commit -m 'deploy'

git push -f  git@github.com:lejjl/sanrenle.github.io.git master

cd -


# git bash    sh deploy.sh