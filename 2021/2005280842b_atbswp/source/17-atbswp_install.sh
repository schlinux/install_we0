#!/bin/bash

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='17-atbswp_install'
VERSAO='V200528av1'
ASSINATURA='#we0_2005280842b_atbswp'
VTIPO=' Keyboard Macro Recorder - instalador'
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
DIR=/mnt/sd6/opt/home/schipani3/2020/
if [[ ! -e ${DIR} ]]; then
   mkdir ${DIR}
elif [[ ! -d ${DIR} ]]; then
    echo "${DIR} already exists but is not a directory" 1>&2
fi   

cd ${DIR}
sudo apt install git python3-dev python3-tk python3-setuptools python3-wheel python3-pip python3-wxgtk4.0
git clone https://github.com/RMPR/atbswp.git && cd atbswp
python3 -m pip install -r requirements-dev.txt
python3 atbswp/atbswp.py
}

CABEC
PRG

#EOL

