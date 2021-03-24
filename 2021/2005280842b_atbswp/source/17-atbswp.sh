#!/bin/bash

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='17-atbswp'
VERSAO='V200528gv1'
ASSINATURA='#we0_2005280842b_atbswp'
VTIPO=' Keyboard Macro Recorder '
VMODO=' Modo: prg stand-alone - nao-interativo - local '
VOBS=' observacoes opcionais '
# Selecionar o modo: (a partir de V150319n)
# OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
VINTERA="ALFA"
# OPCAO BRAVO: INTERATIVO - MODO TEXTO:
# VINTERA="BRAVO"
# OPCAO CHARLIE: INTERATIVO - MODO GRAFICO:
# VINTERA="CHARLIE"
}

PRG()
{
DIR2=/mnt/sd6/opt/home/schipani3/2020
DIR1=${DIR2}/${PRGR}
if [[ ! -e ${DIR1} ]]; then
   mkdir ${DIR1}
elif [[ ! -d ${DIR1} ]]; then
    echo "${DIR1} already exists but is not a directory" 1>&2
fi   

cd ${DIR1}
python3 ${DIR2}/atbswp/atbswp/atbswp.py &
}

CABEC
PRG

#EOL

