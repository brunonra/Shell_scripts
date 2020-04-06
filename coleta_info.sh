#!/bin/bash

###############
#
# script to get server information
# This script checks the OS version and do the commands based on that version
#
#
#
#
###############

> inventario_qa_v1.txt
> inventario_upar_v1.txt
> srv_webl_v1.txt
> indisponivel_v1.txt

#for srv in `cat servidores.txt`

for srv in `cat servidores_v1.txt`
do
        hname=$(ssh -o ConnectTimeout=3 $srv 'hostname' 2>> /dev/null)
                if [ $? -eq 0 ]
                        then
                                echo "$srv - Disponivel coletando informacoes"
                                so=$(ssh $srv 'lsb_release -r | cut -d ":" -f 2 | cut -f2' 2>> /dev/null)
                                        case $so in
                                                4) #echo "Red-hat $so"
                                                        nome=$(ssh $srv 'hostname')
                                                        cpu=$(ssh $srv 'grep -c ^processor /proc/cpuinfo')
                                                        cpum=$(ssh $srv 'cat /proc/cpuinfo |grep -i "model name" |sort -u | cut -d: -f 2')
                                                        memo=$(ssh $srv 'cat /proc/meminfo | grep -i "memtotal"')
                                                        rhrl=$(ssh $srv 'cat /etc/redhat-release |cut -d " " -f 7' 2>> /dev/null)
                                                        krnrl=$(ssh $srv 'uname -r')
                                                        net=$(ssh $srv 'ifconfig |grep "Bcast" |cut -d" " -f12 |cut -d ":" -f2')
                                                        serial=$(ssh $srv 'dmidecode |grep "Serial" | grep -i vmware |cut -d " " -f 3 |cut -d"-" -f 1')
                                                                if [ $serial == VMware ] 2>> /dev/null
                                                                        then
                                                                                serial1=Virtual
                                                                        else
                                                                                serial1=FISICO
                                                                fi
                                                ;;
                                                5.*) #echo "Red-hat $so"
                                                        nome=$(ssh $srv 'hostname')
                                                        cpu=$(ssh $srv 'grep -c ^processor /proc/cpuinfo')
                                                        cpum=$(ssh $srv 'cat /proc/cpuinfo |grep -i "model name" |sort -u | cut -d: -f 2')
                                                        memo=$(ssh $srv 'cat /proc/meminfo | grep -i "memtotal"')
                                                        rhrl=$(ssh $srv 'cat /etc/redhat-release |cut -d " " -f 7' 2>> /dev/null)
                                                        krnrl=$(ssh $srv 'uname -r')
                                                        net=$(ssh $srv 'ifconfig |grep "Bcast" |cut -d" " -f12 |cut -d ":" -f2')
                                                        serial=$(ssh $srv 'dmidecode |grep "Serial" | grep -i vmware |cut -d " " -f 3 |cut -d"-" -f 1')
                                                                if [ $serial == VMware ] 2>> /dev/null
                                                                        then
                                                                                serial1=Virtual
                                                                        else
                                                                                serial1=FISICO
                                                                fi
                                                ;;
                                                6.*) #echo "Red-hat $so"
                                                        nome=$(ssh $srv 'hostname')
                                                        cpu=$(ssh $srv 'grep -c ^processor /proc/cpuinfo')
                                                        cpum=$(ssh $srv 'cat /proc/cpuinfo |grep -i "model name" |sort -u | cut -d: -f 2')
                                                        memo=$(ssh $srv 'cat /proc/meminfo | grep -i "memtotal"')
                                                        rhrl=$(ssh $srv 'cat /etc/redhat-release |cut -d " " -f 7' 2>> /dev/null)
                                                        krnrl=$(ssh $srv 'uname -r')
                                                        net=$(ssh $srv 'ifconfig |grep "Bcast" |cut -d" " -f12 |cut -d ":" -f2')
                                                        serial=$(ssh $srv 'dmidecode |grep "Serial" | grep -i vmware |cut -d " " -f 3 |cut -d"-" -f 1')
                                                                if [ $serial == VMware ] 2>> /dev/null
                                                                        then
                                                                                serial1=Virtual
                                                                        else
                                                                                serial1=FISICO
                                                                fi
                                                ;;
                                                *) so2=$(ssh -o ConnectTimeout=3 $srv 'uname -a |cut -d " " -f 1')
                                                        if [ $so2 = AIX ]
                                                                then
                                                                        #echo $so2
                                                                        nome=$(ssh $srv 'hostname')
                                                                        cpu=$(ssh $srv 'prtconf | grep -i "Number Of Processors" |cut -d ":" -f 2')
                                                                        cpum=$(ssh $srv 'prtconf | grep -i "Processor Type" |cut -d ":" -f 2')
                                                                        memo=$(ssh $srv 'svmon |grep memory |cut -d " " -f 7')
                                                                        rhrl=$(ssh $srv 'uname -v')
                                                                        krnrl=$(ssh $srv 'lslpp -l | grep bos.mp | sort -u |cut -d " " -f 22')
                                                                        serial1="VIRTUAL/LPAR"
                                                                        net=$(ssh $srv 'ifconfig -a |grep -i inet |cut -d " " -f 2')
                                                                else
                                                                        if [ $so2 = SunOS ]
                                                                then
                                                                        #echo $so2
                                                                        nome=$(ssh $srv 'hostname')
                                                                        cpu=$(ssh $srv 'uname -X |grep "NumCPU" | cut -d "=" -f 2')
                                                                        cpum=$(ssh $srv 'uname -m')
                                                                        memo=$(ssh $srv 'prtconf |grep Memory | cut -d " " -f 3')
                                                                        rhrl=$(ssh $srv 'uname -X |grep "Release" | cut -d "=" -f 2')
                                                                        krnrl=$(ssh $srv 'uname -a | cut -d " " -f 4')
                                                                        serial1="FISICO/SPARC"
                                                                        net=$(ssh $srv 'ifconfig -a |grep "broadcast" | cut -d " " -f 2')
                                                                else
                                                                        so3=$(ssh -o ConnectTimeout=3 $srv 'cat /etc/redhat-release |cut -d " " -f 7' 2>> /dev/null)
                                                                        nome=$(ssh $srv 'hostname')
                                                                        cpu=$(ssh $srv 'grep -c ^processor /proc/cpuinfo')
                                                                        cpum=$(ssh $srv 'cat /proc/cpuinfo |grep -i "model name" |sort -u | cut -d: -f 2')
                                                                        memo=$(ssh $srv 'cat /proc/meminfo | grep -i "memtotal"')
                                                                        rhrl=$(ssh $srv 'cat /etc/redhat-release |cut -d " " -f 7' 2>> /dev/null)
                                                                        krnrl=$(ssh $srv 'uname -r')
                                                                        net=$(ssh $srv 'ifconfig |grep "Bcast" |cut -d" " -f12 |cut -d ":" -f2')
                                                                        serial=$(ssh $srv 'dmidecode |grep "Serial" | grep -i vmware |cut -d " " -f 3 |cut -d"-" -f 1')

                                                                fi
                                                        fi
                                                ;;
                                esac


                hname=$(ssh -o ConnectTimeout=3 $srv 'hostname' 2>> /dev/null)
                vdb=$(ssh $srv 'ls /etc/oratab' 2>>/dev/null)
                        if [ $? != 0 ]
                                then
                                        webl=$(ssh -o ConnectTimeout=3 $srv 'ls /opt/web/*/config.xml' 2>> /dev/null)
                                                if [ $? -eq 0 ]
                                                        then
                                                                amb="WEBLOGIC"
                                                                echo "$srv - WEBLOGIC"
                                                        else
                                                                amb="APLICACAO"
                                                                echo "$srv - APLICACAO"
                                                fi
                                else
                                        amb="BANCO DE DADOS"
                                        echo "$srv - BANCO DE DADOS"
                        fi
                echo "Nome: $nome - CPU: $cpu - TIPO: $cpum  - MEM: $memo - SO: $rhrl - KERNEL: $krnrl - IP: $net - MODELO: $serial1 - AMBIENTE: $amb - USR: $usrweb - SENHA: $pssweb - BANCO: $dbn" >> inventario_v1.txt
                        else
                                echo "$srv - Indisponivel" >> indisponivel_v1.txt
                fi

done

sed -i '/Memoria:/s/ MemTotal:[ ]\+/ /g' inventario_upar_v1.txt
sed -i '/Modelo:/s/Modelo:[ ]\+/ /g' inventario_upar_v1.txt
sed -i "/BANCO/s/:\/.*$/');/" inventario_upar_v1.txt