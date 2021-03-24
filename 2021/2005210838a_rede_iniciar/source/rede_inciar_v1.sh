#!/bin/bash
# Tipo: Iniciar rede sshfs - local
# VERSAO='V2005210850a'
# Assinatura: #we0_2005210838a_rede_iniciar

killall sshfs ; sshfs -o nonempty  user@10.0.0.213:'/mnt/winxp/Documents and Settings/All Users/Desktop/schlga410' '/mnt/sd6/home/schipani3/Área de Trabalho/rede_sshfs1' &
