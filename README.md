# deploy-rails-with-docker
Script em docker-compose para que facilmente possa se fazer deploy em uma instancia na AWS que tenha docker e git instalados.

# Requisitos
   Precisa estar com uma conexao ssh a uma instancia da AWS EC2, que esteja com uma versão do Linux Ubuntu x86 16.04 ou superior. Portas (22 e 80) precisam estar liberadas no Security Group.

# No terminal shh de sua instancia de o comando
   - sudo su
# Em seguida copie e cole linha por linha, sempre precionando enter após cada colagem
   - apt-get update
   - apt-get install git-core
   - git clone https://github.com/abel-cabral/deploy-rails-with-docker
   - cd deploy-rails-with-docker
# Por ultimo inicie o script de os seguites comando
    - chmod 777 partOne.sh
    - bash ./partOne.sh
# Obs o segundo script será chamado automaticamente pelo primeiro, ao ver uma mensagem de sucesso estará tudo finalizado. Bom trabalho!

# vídeo de Apoio
