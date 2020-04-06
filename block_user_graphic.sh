#!/bin/bash

# Fazendo o script para blindar usuario conforme a seleção do usuario
# Por enquanto só funciona para LINUX< depois eu vou implementar as ações para os UNIX da vida
opmn=$(whiptail --title "Tipo de Blindagem" --menu "Por favor informar se a blindagem sera manual ou automatica: $srv" --fb 25 40 10 \
        "1" "Manual" \
        "2" "Automatica" \
        "3" "Sair" 3>&1 1>&2 2>&3)

if [ $opmn -eq 1 ]

then

        srv=$(whiptail --title "Blindagem" --inputbox "Digite o nome do servidor para Blindar ou Desblindar: " --fb 10 60 3>&1 1>&2 2>&3)
        data=$(date)
                clear
        teste1=$(ping -c 3 $srv 2>> /dev/null)

# esse IF traz o menu com as opcoes de bloqueio
        if [ $? -eq 0 ]

then
        opcao=$(whiptail --title "Menu" --menu "Escolha o que deseja fazer: $srv" --fb 25 70 10 \
        "1" "Para blindar um usuario no servidor" \
        "2" "Para desblindar um usuario no servidor" \
        "3" "Por hora ND" \
        "4" "Por hora ND" \
        "5" "Por hora ND" \
        "6" "Por hora ND" \
        "7" "Por hora ND" \
        "8" "Por hora ND" \
        "9" "Valida blindagem" 3>&1 1>&2 2>&3)

status=$?

#if [ $status = 0 ]; then
#    echo "Sua distro é:" $opcao

        case $opcao in

                1) usuario=$(whiptail --title "Blindagem de Usuario" --inputbox "Por favor informe o nome do usuario que deseja blindar:" --fb 10 60 3>&1 1>&2 2>&3)
                                        if [ $usuario == root ]
                                                then
                                                        echo "usuario ROOT nao pode ser blindado"
                                                        exit
                                        fi
                                        if [ $usuario == ANOTHER_USER]
                                                then
                                                        echo "usuario ANOTHER_USER nao pode ser blindado"
                                                        exit
                                        fi
                                        echo "Blindando o usuario: $usuario" > test_textbox
                                bldusr=$(ssh $srv usermod -s /bin/nologin ${usuario})
                                echo "Derrubando sessoes ativas do usuario $usuario" >> test_textbox
                                               matausr=$(ssh $srv pkill -u $usuario sshd)
                                        evidencia=$(ssh $srv cat /etc/passwd |grep ${usuario})
                                echo "Usuario blindado com sucesso: $evidencia" >> test_textbox
                                whiptail --title "Blindagem de usuario" --textbox --scrolltext test_textbox 20 80
                ## BLOCO PARA NOVA BLINDAGEM, COMECANDO O PROCESSO DESDE O INICIO
                                bl2=$(whiptail --title "Desblindagem de Usuario" --inputbox "Deseja blindar outro usuario? (Y/N)" --fb 10 60 3>&1 1>&2 2>&3)
                                        if [ $bl2 == Y ] | [ $bl2 == yes ] | [ $bl2 == Yes ] | [ $bl2 == YES ] | [ $bl2 == y ]
                                                then
                                                        PATCH_OF_THE_SCRITP/SCRIPT_NAME.sh
                                                else
                                                        clear
                                                        exit
                                        fi
                ## FIM DO BLOCO

                ;;

                2) usuario=$(whiptail --title "Desblindagem de Usuario" --inputbox "Por favor informe o nome do usuario que deseja desblindar:" --fb 10 60 3>&1 1>&2 2>&3)
                                        if [ $usuario == root ]
                                                then
                                                        echo "usuario ROOT nao pode ser desblindado"
                                                        exit
                                        fi
                                        if [ $usuario == qaadm ]
                                                then
                                                        echo "usuario QAADM nao pode ser desblindado"
                                                        exit
                                        fi
                                 echo "Desblindando o usuario: $usuario" > test_textbox
                                        bldusr=$(ssh $srv usermod -s /bin/bash ${usuario})
                                        evidencia=$(ssh $srv cat /etc/passwd |grep ${usuario})
                                echo "Usuario desblindado com sucesso: $evidencia" >> test_textbox
                                whiptail --title "Desblindagem de usuario" --textbox --scrolltext test_textbox 20 80
                                bl2=$(whiptail --title "Desblindagem de Usuario" --inputbox "Deseja desblindar outro usuario? (Y/N)" --fb 10 60 3>&1 1>&2 2>&3)
                                        if [ $bl2 == Y ] | [ $bl2 == yes ] | [ $bl2 == Yes ] | [ $bl2 == YES ] | [ $bl2 == y ]
                                                then
                                                        PATCH_OF_THE_SCRITP/SCRIPT_NAME.sh
                                                else
                                                        exit
                                        fi
                ;;

                3) exit
                ;;

                4) exit
                ;;

                8) exit
                  # motivo=$(whiptail --title "Relatorio Pre-boot $srv" --inputbox "Informe o motivo do boot: " --fb 10 60 3>&1 1>&2 2>&3)
                  # nome1=$(whiptail --title "Relatorio Pre-boot $srv" --inputbox "Informe o nome de quem solicitou o Reboot: " --fb 10 60 3>&1 1>&2 2>&3)
                  # nome2=$(whiptail --title "Relatorio Pre-boot $srv" --inputbox "Informe o nome de quem esta fazendo o Reboot: " --fb 10 60 3>&1 1>&2 2>&3)
#barrinha de progresso, mó legal, vai ficar aqui
#{
#        for ((i = 0 ; i <= 100 ; i+=1)); do
#            sleep 0.1
#            echo $i
#        done
#
#} | whiptail --title "Coleta Pre-boot do $srv" --gauge "coletando informacoes, por favor espere" 6 50 0
#fim da barrinha, quero ver se vou usar
                ;;

                        9) solic=$(whiptail --title "Valida blindagem" --inputbox "Informe o usuario que deseja ver se esta Blindado: " --fb 10 60 3>&1 1>&2 2>&3)

                                {
                                for ((i = 0 ; i <= 100 ; i+=1)); do
                                sleep 0.1
                                echo $i
                                done
                                #dcheck=$(ssh $srv cat /etc/passwd |grep $solic)
                } | whiptail --title "" --gauge "Verificando, por favor esperar" 6 50 0
                                        dcheck2=$(ssh $srv cat /etc/passwd |grep $solic)
                                        dcheck=$(ssh $srv cat /etc/passwd |grep $solic | cut -d ":" -f 7)
                                        echo "Informacoes do usuario: $dcheck2" > teste_textbox
                                                if [ $dcheck == "/bin/nologin" ]
                                                        then
                                                                echo "Usuario $solic ainda esta BLINDADO" >> teste_textbox
                                                        else
                                                                echo "Usuario $solic ainda esta DESBLINDADO" >> teste_textbox
                                                fi
                                        echo "detalhes do usuario: $dcheck2" >> teste_textbox
                                         whiptail --title "Status da conta" --textbox --scrolltext teste_textbox 10 60

                                ;;


                *) echo "Opcao invalida"
                   echo "retornando ao menu principal"
                        sleep 5
                        PATCH_OF_THE_SCRITP/SCRIPT.SH
                ;;
        esac
#else
#    echo "Você cancelou."
#fi

else
        echo "$srv nao responde a ping."
        echo "Por favor selecionar outro Nome IP ou acionar o time de linux"

fi

else
        echo "Voce escolheu a blindagem AUTOMATICA"
fi