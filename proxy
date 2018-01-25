#!/bin/bash

# [ PROXY STRATUM METHOD ]

# [ VARIABLES ]

carteira=
usuario=
senha=

# [ SCRIPT ]

# Obtém a carteira
if [ -z "${carteira-}" ]; then
  echo
  read -p "[read] Entre com a carteira: " carteira
fi

# Obtém o nome do usuário
if [ -z "${usuario-}" ]; then
  echo
  read -p "[read] Entre com o nome do usuário: " usuario
fi

# Obtém a senha do usuário
if [ -z "${senha-}" ]; then
  echo
  read -p "[read] Entre com a senha do usuário: " senha
fi

# [ JDK Install ] 

sudo apt-get update
sudo apt-get install default-jre
sudo apt-get install default-jdk

# [ Extras ]

sudo apt-get install nodejs
sudo apt-get install maven

# [ Stratum Proxy ]

wget https://github.com/darkstilo/stratum-proxy/archive/v0.8.1.1-malthraxcrypto.tar.gz -O v0.8.1.1-malthraxcrypto.tar.gz

tar -xzvf v0.8.1.1-malthraxcrypto.tar.gz
cd stratum-proxy-0.8.1.1-malthraxcrypto
mvn clean package
cd target

wget https://github.com/darkstilo/stratum-proxy/releases/download/v0.8.1.1-malthraxcrypto/stratum-proxy-yescrypt.conf -O stratum-proxy-yescrypt.conf

# Convert formato dos2unix
# awk '{printf "%s\r\n", $0}' stratum-proxy-yescrypt.conf

# Insere as variáveis
sed -i 's/XMY/BTC/g' stratum-proxy-yescrypt.conf
sed -i "s/\"user\" :.*/\"user\" \: \"${carteira}\"\,/" stratum-proxy-yescrypt.conf
sed -i "s/\"apiUser\":.*/\"apiUser\"\: \"${usuario}\"\,/" stratum-proxy-yescrypt.conf
sed -i "s/\"apiPassword\":.*/\"apiPassword\"\: \"${senha}\"\,/" stratum-proxy-yescrypt.conf

# Executa o proxy

java -jar stratum-proxy-0.8.1-malthraxcrypto.jar --conf-file=stratum-proxy-yescrypt.conf
