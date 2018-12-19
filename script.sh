#!/bin/bash
# Dados de acesso a sua conta
read -p 'Ruby Version: ' ruby
read -p 'Git Username: ' uservar
read -sp 'Git Password: ' passvar
echo
read -p 'URL Project: ' project

# Sem remove https
URL="${project/'https://'/''}" 
CUSTOMURL="https://${uservar}:${passvar}@${URL}"
WORKDIR="myapp"

cat <<EOT >> Dockerfile    
    # Versao do Ruby
    FROM ruby:${ruby}
    # Atualiza repositorios
    RUN apt-get update
    # Instala o git
    RUN apt-get install -y git
    # Criamos uma pasta pro projeto
    RUN mkdir /${WORKDIR}
    # Definimos /${WORKDIR} como pasta padrao de trabalho
    WORKDIR /${WORKDIR} 
    # Script que irá o projeto do repositório do gitlab, . significa que baixaremos apenas os arquivos, descartando a pasta
    RUN git clone ${CUSTOMURL} .
    # Copiamos tudo para nossa workdir
    COPY . /${WORKDIR}
    # Variavel
    ENV BUNDLE_PATH /bundle
    # Lê o gem file e instala a versão do rails lá informada
    RUN bundle install
    # Baixamos Node
    RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
    # Installa o Node
    RUN  apt-get install -y nodejs
    # Permite a visualização dinâmica de um arquivo, ou seja, as linhas são exibidas na tela na medida em que são geradas
    CMD tail -f /dev/null
    # Ira deletar esse script ao terminar assim seus dados nao estaram vulneraveis
    RUN echo 'As máquinas dominarão o mundo!'
EOT

cat <<EOT >> docker-compose.yml  
version: "3.3"
services:
  db:
    image: postgres:9.4.1
    ports:
      - "5432:5432"
    environment:
      -  POSTGRES_PASSWORD=password
    volumes:
      - /home/sivakumar/dev/volumes/pgdata/etc:/etc/postgresql:Z
      - /home/sivakumar/dev/volumes/pgdata/log:/var/log/postgresql:Z
      - /home/sivakumar/dev/volumes/pgdata/data:/var/lib/postgresql/data:Z
  app:
    # Builda a image no DockerFile
    build: .    
    command: bundle exec rails s -b 0.0.0.0
      
    environment:
      - BUNDLE_PATH=/bundle
    ports:
      # Porta da Máquina:Porta do Container
      - 80:3000
    links:
      # liga esse container ao acima criado
      - db
    volumes:
        # localizacao da nossa workdir
      - .:/var/${WORKDIR}      
volumes:
  bundle:
    # Finaliza excluindo dados de login    
EOT

echo "                                                                                                                                                          ";
echo "                                                                                                                                                          ";
echo "IIIIIIIIIINNNNNNNN        NNNNNNNN               JJJJJJJJJJJUUUUUUUU     UUUUUUUUNNNNNNNN        NNNNNNNNIIIIIIIIII     OOOOOOOOO     RRRRRRRRRRRRRRRRR   ";
echo "I::::::::IN:::::::N       N::::::N               J:::::::::JU::::::U     U::::::UN:::::::N       N::::::NI::::::::I   OO:::::::::OO   R::::::::::::::::R  ";
echo "I::::::::IN::::::::N      N::::::N               J:::::::::JU::::::U     U::::::UN::::::::N      N::::::NI::::::::I OO:::::::::::::OO R::::::RRRRRR:::::R ";
echo "II::::::IIN:::::::::N     N::::::N               JJ:::::::JJUU:::::U     U:::::UUN:::::::::N     N::::::NII::::::IIO:::::::OOO:::::::ORR:::::R     R:::::R";
echo "  I::::I  N::::::::::N    N::::::N                 J:::::J   U:::::U     U:::::U N::::::::::N    N::::::N  I::::I  O::::::O   O::::::O  R::::R     R:::::R";
echo "  I::::I  N:::::::::::N   N::::::N                 J:::::J   U:::::D     D:::::U N:::::::::::N   N::::::N  I::::I  O:::::O     O:::::O  R::::R     R:::::R";
echo "  I::::I  N:::::::N::::N  N::::::N                 J:::::J   U:::::D     D:::::U N:::::::N::::N  N::::::N  I::::I  O:::::O     O:::::O  R::::RRRRRR:::::R ";
echo "  I::::I  N::::::N N::::N N::::::N                 J:::::j   U:::::D     D:::::U N::::::N N::::N N::::::N  I::::I  O:::::O     O:::::O  R:::::::::::::RR  ";
echo "  I::::I  N::::::N  N::::N:::::::N                 J:::::J   U:::::D     D:::::U N::::::N  N::::N:::::::N  I::::I  O:::::O     O:::::O  R::::RRRRRR:::::R ";
echo "  I::::I  N::::::N   N:::::::::::N     JJJJJJJ     J:::::J   U:::::D     D:::::U N::::::N   N:::::::::::N  I::::I  O:::::O     O:::::O  R::::R     R:::::R";
echo "  I::::I  N::::::N    N::::::::::N     J:::::J     J:::::J   U:::::D     D:::::U N::::::N    N::::::::::N  I::::I  O:::::O     O:::::O  R::::R     R:::::R";
echo "  I::::I  N::::::N     N:::::::::N     J::::::J   J::::::J   U::::::U   U::::::U N::::::N     N:::::::::N  I::::I  O::::::O   O::::::O  R::::R     R:::::R";
echo "II::::::IIN::::::N      N::::::::N     J:::::::JJJ:::::::J   U:::::::UUU:::::::U N::::::N      N::::::::NII::::::IIO:::::::OOO:::::::ORR:::::R     R:::::R";
echo "I::::::::IN::::::N       N:::::::N      JJ:::::::::::::JJ     UU:::::::::::::UU  N::::::N       N:::::::NI::::::::I OO:::::::::::::OO R::::::R     R:::::R";
echo "I::::::::IN::::::N        N::::::N        JJ:::::::::JJ         UU:::::::::UU    N::::::N        N::::::NI::::::::I   OO:::::::::OO   R::::::R     R:::::R";
echo "IIIIIIIIIINNNNNNNN         NNNNNNN          JJJJJJJJJ             UUUUUUUUU      NNNNNNNN         NNNNNNNIIIIIIIIII     OOOOOOOOO     RRRRRRRR     RRRRRRR";
echo "                                                                                                                                                          ";
echo "                                                                                                                                                          "; 

# Apenas builda nossos container, mas nao executa
docker-compose build
# Deleta o arquivo que continha dados do usuario
rm -f Dockerfile
# Apenas limpa o terminal bash
#clear
echo "                                                                                                                           ";
echo "                                                                                                                           ";
echo "     OOOOOOOOO     NNNNNNNN        NNNNNNNNLLLLLLLLLLL             IIIIIIIIIINNNNNNNN        NNNNNNNNEEEEEEEEEEEEEEEEEEEEEE";
echo "   OO:::::::::OO   N:::::::N       N::::::NL:::::::::L             I::::::::IN:::::::N       N::::::NE::::::::::::::::::::E";
echo " OO:::::::::::::OO N::::::::N      N::::::NL:::::::::L             I::::::::IN::::::::N      N::::::NE::::::::::::::::::::E";
echo "O:::::::OOO:::::::ON:::::::::N     N::::::NLL:::::::LL             II::::::IIN:::::::::N     N::::::NEE::::::EEEEEEEEE::::E";
echo "O::::::O   O::::::ON::::::::::N    N::::::N  L:::::L                 I::::I  N::::::::::N    N::::::N  E:::::E       EEEEEE";
echo "O:::::O     O:::::ON:::::::::::N   N::::::N  L:::::L                 I::::I  N:::::::::::N   N::::::N  E:::::E             ";
echo "O:::::O     O:::::ON:::::::N::::N  N::::::N  L:::::L                 I::::I  N:::::::N::::N  N::::::N  E::::::EEEEEEEEEE   ";
echo "O:::::O     O:::::ON::::::N N::::N N::::::N  L:::::L                 I::::I  N::::::N N::::N N::::::N  E:::::::::::::::E   ";
echo "O:::::O     O:::::ON::::::N  N::::N:::::::N  L:::::L                 I::::I  N::::::N  N::::N:::::::N  E:::::::::::::::E   ";
echo "O:::::O     O:::::ON::::::N   N:::::::::::N  L:::::L                 I::::I  N::::::N   N:::::::::::N  E::::::EEEEEEEEEE   ";
echo "O:::::O     O:::::ON::::::N    N::::::::::N  L:::::L                 I::::I  N::::::N    N::::::::::N  E:::::E             ";
echo "O::::::O   O::::::ON::::::N     N:::::::::N  L:::::L         LLLLLL  I::::I  N::::::N     N:::::::::N  E:::::E       EEEEEE";
echo "O:::::::OOO:::::::ON::::::N      N::::::::NLL:::::::LLLLLLLLL:::::LII::::::IIN::::::N      N::::::::NEE::::::EEEEEEEE:::::E";
echo " OO:::::::::::::OO N::::::N       N:::::::NL::::::::::::::::::::::LI::::::::IN::::::N       N:::::::NE::::::::::::::::::::E";
echo "   OO:::::::::OO   N::::::N        N::::::NL::::::::::::::::::::::LI::::::::IN::::::N        N::::::NE::::::::::::::::::::E";
echo "     OOOOOOOOO     NNNNNNNN         NNNNNNNLLLLLLLLLLLLLLLLLLLLLLLLIIIIIIIIIINNNNNNNN         NNNNNNNEEEEEEEEEEEEEEEEEEEEEE";
echo "                                                                                                                           ";
echo "                                                                                                                           ";
# Inicias nossos containers
docker-compose up
