#!/bin/bash


clear

echo "Preparando o portal inventario."
echo "Por favor atentar para os requisitos abaixo:"
echo "1 - Docker instalado no servidor"
echo "2 - Conexao com a internet para acesso ao DockerHub e Gitlab"
echo "3 - Relacao de confianca entre o servidor do Docker e o parque"
        sleep 2
        clear
echo "Iniciando a preparacao do ambiente docker..."
echo "Verificando se o docker esta ativo: "
        tst=$(rpm -qa |grep docker | wc -l)
        if [ ${tst} -ge 1 ]
        then
                #clear
                echo "Docker no ar, baixando as imagens:"
                docker pull tiobaca/tiobacahub:brunoans
                docker pull tiobaca/tiobacahub:portal_httpd
                docker pull tiobaca/tiobacahub:portalpsql

                clear
                echo "Download das imagens concluido, preparando para subir os containers:"

                echo "Preparando container ansible"
                        ANID=$(docker image ls |grep brunoans | cut -d " " -f 11)
                        docker run -d --name portalansible --restart always -v /opt/ansible:/opt/ansible/ -v /etc/hosts:/etc/hosts -v /opt/ansible/inventory:/etc/ansible -v /opt/ansible/logs:/opt/ansible/logs -t ${ANID}

                echo "Preparando o container apache"
                        APID=$(docker image ls |grep portal_httpd | cut -d " " -f 7)
                        docker run -d -t -p 80:80 --restart always --privileged -v /opt/web/apache:/var/www/html --name portal_http ${APID} /usr/sbin/init

                echo "Preparando o container de banco"
                        DBID=$(docker image ls |grep portalpsql | cut -d " " -f 9)
                        docker run -d -p 5432:5432 --restart always --name portal_bd  -e POSTGRES_PASSWORD=P0rta1! -e PGDATA=/opt/postgresql/pgdata -v /opt/postgresql:/var/lib/postgresql/data ${DBID}

                echo "Preparando alias do ansible e github"
                echo 'alias ansible-playbook="docker exec -it portalansible ansible-playbook"' >> /etc/bashrc
                echo 'alias git="docker exec -it portal_http git"' >> /etc/bashrc

                echo "Pegando portal do github"
                docker exec -it portal_http mkdir /opt/web/portal
                docker exec -it portal_http git clone https://github.com/brunonra/Novo_portal.git /opt/web/portal

                echo "Ajustando portal no apache"
                docker cp portal_http:/opt/web/portal/html/ /opt/web/
                cp -rp /opt/web/html/*.php /opt/web/apache/
                cp -rp /opt/web/html/style /opt/web/apache/

                echo "Corrigindo acessos do apache ao banco de dados."
                IPM=$(hostname -I | cut -d" " -f 1)
                sed -i "/5432/s/localhost/${IPM}/" /opt/web/apache/*.php



        else
                echo "Servico do docker esta fora, por favor validar e rodar novamente o script."
        fi
