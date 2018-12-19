# deploy-rails-with-docker
Script em docker-compose para que facilmente possa se fazer deploy em uma instancia na AWS que tenha docker e git instalados.

PARTE I - (Linux Ubuntu 16.04 < )
#Docker
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" -y
sudo apt-get update
sudo apt-get install docker-ce -y
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
#Docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
#Git
sudo apt-get update
sudo apt-get install git-core


PARTE II
- sudo su
- git clone https://github.com/abel-cabral/deploy-rails-with-docker
Acesse a pasta baixada
- cd deploy-rails-with-docker
De permição ao script
- chmod 777 script.sh
Rode o Script
- /script.sh
