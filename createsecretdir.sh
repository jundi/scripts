dir=$(pwd)
message=$3
pass=$2
user=$1

echo "AuthType Basic
AuthName $message
AuthUserFile $dir/.pass
Require user $user" > .htaccess

htpasswd -cb $dir/.pass $user $pass
