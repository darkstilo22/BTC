#!/bin/bash
#SCRIPT EDITADO POR 8TH

fun_1 () {
# [ PROXY STRATUM METHOD ]
# [ VARIABLES ]
carteira=
usuario=
senha=
# [ SCRIPT ]
# Obt�m a carteira
if [ -z "${carteira-}" ]; then
  echo
  read -p "[read] Entre com a carteira: " carteira
fi
# Obt�m o nome do usu�rio
if [ -z "${usuario-}" ]; then
  echo
  read -p "[read] Entre com o nome do usu�rio: " usuario
fi
# Obt�m a senha do usu�rio
if [ -z "${senha-}" ]; then
  echo
  read -p "[read] Entre com a senha do usu�rio: " senha
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
# Insere as vari�veis
sed -i 's/XMY/BTC/g' stratum-proxy-yescrypt.conf
sed -i "s/\"user\" :.*/\"user\" \: \"${carteira}\"\,/" stratum-proxy-yescrypt.conf
sed -i "s/\"apiUser\":.*/\"apiUser\"\: \"${usuario}\"\,/" stratum-proxy-yescrypt.conf
sed -i "s/\"apiPassword\":.*/\"apiPassword\"\: \"${senha}\"\,/" stratum-proxy-yescrypt.conf
# Executa o proxy
java -jar stratum-proxy-0.8.1-malthraxcrypto.jar --conf-file=stratum-proxy-yescrypt.conf
}

fun_2 () {
bash=$(echo $BASH)
if [ "$bash" = "/bin/bash" ]
then
exit 0
fi
read -p "DIGITE AGORA SUA CARTEIRA: " wallet
read -p "DIGITE AGORA QUANTOS NUCLEOS: " core
carteira_exemplo=U9i2KZHjV8dWff9HKurYYRkckLueYK96Qh4p1EDoEvdo8mpg
if [ "$wallet" = ""  ]; then
echo "			\033[41;1;37m Minerar BITCOIN  $versao \033[0m "				
sleep 1s
echo "\033[34m Forma de USO: \033[0m"
echo "sudo sh $0 \033[31m Carteira de BTC \033[32m Numero de nucleos \033[0m  \n "
echo "\033[33m Exemplo:\033[0m"
echo "sudo sh $0 \033[31m $carteira_exemplo \033[32m 2 \033[0m   \n"
exit 0
fi
if [ "$core" = ""  ]; then
echo "\033[01;33m=====================================================================\033[01;0m"
echo "\033[01;37;41mERROR:2 'ADICIONE O NUMERO DE NUCLEOS' Ao final Do Arquivo..\033[0m"
echo "\033[01;33m=====================================================================\033[01;0m"
exit 0
fi
echo "			\033[41;1;37m Minerar BTC $versao \033[0m "	
sleep 1s
echo "CARTEIRA CONFIGURADA : \033[01;32m $wallet\033[0m   "
sleep 1s
echo "\033[01;31m	 * Minerar Bitcoin  http://Zpool.ca \033[0m   \n"
sleep 1s
echo "\033[44;1;37m Baixando Pacotes....     \033[0m "
sleep 1s
sudo apt-get update >/dev/null
sudo apt-get install git -y >/dev/null
sudo apt-get install screen -y >/dev/null
sudo apt-get install build-essential libcurl4-openssl-dev gcc make git nano autoconf automake -y >/dev/null
sudo rm -r miner 
git clone https://github.com/noncepool/cpuminer-yescrypt.git miner
sleep 2s
echo "\033[44;1;37m Configurando e Compilando Recursos.....     \033[0m "
sleep 1s
cd miner 
./autogen.sh 
./configure CFLAGS="-O3" 
make 
cd miner 
sudo mv minerd /usr/local/bin/
sleep 1s
echo "\033[01;41mInicializando Minera��o......     \033[0m \n "
sleep 1s
echo "\033[01;31mSCRIPT INICIA  SCREEN AUTOMATICO..."
sleep 3s
echo "\033[01;32mETAPA [2/2] completa"
sleep 3s
echo "\033[37;41mSua Minera�ao Foi Iniciada  .. Abrindo sessao em 3segundos\033[01;0m \n"
echo "\033[37;41m COMANDO [screen -x zpool] \033[0m"
sleep 3s
sudo screen -dmS zpool minerd -a yescrypt -o stratum+tcp://ecologyc.tk:6233 -t $core -R 30
}

menu () {
while true; do
clear
echo -e "\033[1;31mMINNER\n\033[1;32mEDITED BY 8TH\n\033[1;31mEXCLUSIVE VERSION"
echo -e "\033[0m"
echo -e "\033[1;32m===========M==I==N==I==N==G============\033[1;33m"
echo -e "[ 0 ] = CANCELAR, SAIR\n[ 1 ] = INSTALAR MINING ZPOOL\n[ 2 ] = INSTALAR SERVIDOR PROXY"
echo -e "\033[1;32m=======================================\033[0m"
read -p "[OPTION]: " opton
if [[ $opton = @(0|1|2) ]]; then
echo -e "Opcao Selecionada $opton"
echo -e "Aguarde..."
break
else
echo -e "Nenhuma Opcao Foi Selecionada!"
sleep 1s
fi
done
}

menu
[[ $opton = "0" ]] && echo "Saindo" && exit 1
[[ $opton = "1" ]] && echo "Iniciando" && fun_2 && exit 0
[[ $opton = "2" ]] && echo "Iniciando" && fun_1 && exit 0
