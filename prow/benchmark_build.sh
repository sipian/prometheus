# IMPORTAN ::: This is a bash file to run on Alpine linux

apk update
apk install tree

tree /usr/

echo "\n\n\n\n\n\n*********************************************************************************\n\n\n\n\n\n"
tree ~/

echo "\n\n\n\n\n\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++n\n\n\n\n\n"

echo "Directory name => $(pwd)"

printenv

export -p

docker info

docker version

cat /etc/serviceaccount/service-account.json
