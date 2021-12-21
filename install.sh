#!/bin/bash
apt update
apt install zip unzip net-tools ufw -y
#kill default PID exim4
exim4id=$(ps -A | grep "exim4" | awk '{print $1}') && kill $exim4id
rm -rf /etc/init.d/exim4
#install OpenJDK 8
apt install apt-transport-https ca-certificates wget dirmngr gnupg software-properties-common -y
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
apt update
apt install adoptopenjdk-8-hotspot -y
echo 'JAVA_HOME="/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64"' > /etc/environment
source /etc/environment
#change default java version:
#update-alternatives --config java
java -version
echo '$JAVA_HOME is:'
echo $JAVA_HOME
sleep 5s
#get apache james
wget https://archive.apache.org/dist/james/server/james-server-app-3.1.0-app.zip && unzip james-server-app-3.1.0-app.zip
cd james-server-app-3.1.0/bin
./run.sh >/dev/null &
./james start &
sleep 10s
#set ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 25
ufw allow 110
ufw --force enable
ufw status verbose
#checking port
netstat -nltp
