#!/bin/bash

##
#
# This script block any selected user on the server.
# He avoid blocking the root user (to keep the server main way to access)
# and if you wanna block any other user, just change the second if.
# If you wanna add more "unblockeable" users, just add another  if.
#
###


echo "Bem vindo ao script de Blindagem e Desblindagem do ambiente."
echo "Por favor, escolha o que deseja fazer: "
        echo "1 - Blindagem de ambiente"
        echo "2 - Desblindagem de ambiente"
        echo "3 - Sair"
        read opt

        case $opt in

                1) echo "Por favor informe o nome do usuario que deseja blindar:"
                        read usuario
                                        if [ $usuario == root ]
                                                then
                                                        echo "usuario ROOT nao pode ser blindado"
                                                        exit
                                        fi
                                        if [ $usuario == ANOTHER_CANT_BLOCK_USER ]
                                                then
                                                        echo "usuario XXX nao pode ser blindado"
                                                        exit
                                        fi
                                        echo "Blindando o usuario $usuario"
                                usermod -s /bin/nologin ${usuario}
                                        echo "Derrubando sessoes ativas do usuario $usuario"
                                                pkill -u $usuario sshd
                                        evidencia=$(cat /etc/passwd |grep ${usuario})
                                echo "Usuario blindado com sucesso: $evidencia"
                        ;;
                2) echo "Por favor informe o usuario que deseja DESBLINDAR:"
                        read usuario
                                echo "Desblindando o usuario $usuario"
                                usermod -s /bin/bash ${usuario}
                                        evidencia=$(cat /etc/passwd |grep ${usuario})
                                echo "Usuario desblindado com sucesso: $evidencia"
                        ;;
                3) clear
                        ;;
                *) echo "Opcao invalida, saindo do script"
                        exit
                        ;;
        esac
