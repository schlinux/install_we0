#!/usr/bin/env bash

CABEC()
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='21_1-bckp_pool_v2'
VERSAO='V200826av2-BETA'
ASSINATURA='#we0_2006140624a-bckp_pool'
VTIPO=' SCRIPT DE  BACKUP/UPLOAD TRUECRYPT1'
VMODO=' Modo: prg stand-alone - nao-interativo - local '
VOBS='  '
# Selecionar o modo: (a partir de V150319n)
# OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
VINTERA="ALFA"
# OPCAO BRAVO: INTERATIVO - MODO TEXTO:
# VINTERA="BRAVO"
# OPCAO CHARLIE: INTERATIVO - MODO GRAFICO:
# VINTERA="CHARLIE"

}

INIT()
{
# -----------------------------------------------------------------------------
# Safety settings (see https://gist.github.com/ilg-ul/383869cbb01f61a51c4d).

if [[ ! -z ${DEBUG} ]]
then
  set ${DEBUG} # Activate the expand mode if DEBUG is anything but empty.
else
  DEBUG=""
fi

set -o errexit # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset # Exit if variable not set.

# Remove the initial space and instead use '\n'.
IFS=$'\n\t'

# -----------------------------------------------------------------------------
# Identify the script location, to reach, for example, the helper scripts.

script_path="$0"
if [[ "${script_path}" != /* ]]
then
  # Make relative path absolute.
  script_path="$(pwd)/$0"
fi

script_name="$(basename "${script_path}")"

script_folder_path="$(dirname "${script_path}")"
script_folder_name="$(basename "${script_folder_path}")"

# =============================================================================
}

LOGGER() #cria cabecalho do log file generico
{
DIR=~/log/${PRGR}
if [[ ! -e ${DIR} ]]; then
    mkdir ${DIR}
elif [[ ! -d ${DIR} ]]; then
    echo "${DIR} already exists but is not a directory" 1>&2
fi
 INICIO=`date +%d/%m/%Y-%H:%M:%S`
 LOG=$DIR/${PRGR}_`date +%Y-%m-%d-%H%M`_$$.log
 #CRIA O ARQUIVO DE LOGS
 echo " //JOB " >> $LOG
 echo " " >> $LOG
 echo "PRG: "${PRGR}" - VERSAO: "${VERSAO} >> $LOG
 echo $VTIPO  >> $LOG
 echo "|-----------------------------------------------" >> $LOG
 echo " Prg iniciado em $INICIO" | tee -a $LOG
echo "|-----------------------------------------------" >> $LOG
}

TRAILER()
{
 FINAL=`date +%d/%m/%Y-%H:%M:%S`
 echo "|-----------------------------------------------" >> $LOG
 echo " Prg finalizado em $FINAL" | tee -a $LOG
 echo "|-----------------------------------------------" >> $LOG
 echo " " >> $LOG
 echo " " >> $LOG
}

PRG ()
{
#Entrada crontab
#  SCRIPT DE  BACKUP/UPLOAD TRUECRYPT1  diario  00:50
#50   0   *  *  *  ~/.Programas_iniciar/21-bckp_pool/21_1-bckp_pool.sh   2>  ~/log/crontab_errors/21_1-bckp_pool_err_$$.log

 echo "PRG: "${PRGR}" - VERSAO: "${VERSAO}
 echo $VTIPO
sudo mount -o bind,remount,rw /media/truecrypt2
rsync -a  -v -H --delete  /media/truecrypt1/ /media/truecrypt2 2>&1  |  tee -a $LOG  1> /dev/null
sudo mount -o bind,remount,ro /media/truecrypt2
s3cmd sync -H -v -r  /media/truecrypt2/dropbox_pago/Dropbox/    s3://d-root/gotacaja/ 2>&1  |  tee -a $LOG  1> /dev/null
}

INIT
CABEC
LOGGER
PRG | pv
TRAILER


#EOL
