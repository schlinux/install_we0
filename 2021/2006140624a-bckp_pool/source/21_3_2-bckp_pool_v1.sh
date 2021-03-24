#!/usr/bin/env bash

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='21_3_2-bckp_pool_v1'
VERSAO='V200809bv1-ALFA'
ASSINATURA='#we0_2006140624a-bckp_pool'
VTIPO=' SCRIPT DE SINCRONIZACAO 847 FILESERVER HSALES928-->847 '
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
DIR=~/log/jobs/${PRGR}
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
 echo "PRG: "${PRGR}" - VERSAO: "${VERSAO} 
 echo $VTIPO 
# faz um backup preventivo de dropbox_pago em truecrypt1
#/mnt/sd6/home/schipani3/.Programas_iniciar/21-bckp_pool/21_2-bckp_pool.sh 2>&1  |  tee -a $LOG  1> /dev/null
#soluciona direitos de usuario
#sudo chown -R schipani3:schipani3 /media/schipani3/SEAG04/  2>&1  |  tee -a $LOG  1> /dev/null
#sudo chown -R schipani3:schipani3 /media/truecrypt11/ 2>&1  |  tee -a $LOG  1> /dev/null
# sincronizacao reflexiva cautelosa sem delete 
#rsync  -a -u -H  -v --dry-run /media/truecrypt1/dropbox_pago/ /media/truecrypt2/dropbox_pago 2>&1  |  tee -a $LOG  1> /dev/null
echo '1) tc1 --> tc2 ' 2>&1  |  tee -a $LOG  1> /dev/null
rsync  -a -u -H  -v  /media/truecrypt1/dropbox_pago/ /media/truecrypt2/dropbox_pago 2>&1  |  tee -a $LOG  1> /dev/null
echo '2) tc2 --> tc1' 2>&1  |  tee -a $LOG  1> /dev/null
rsync  -a -u -H  -v /media/truecrypt2/dropbox_pago/ /media/truecrypt1/dropbox_pago 2>&1  |  tee -a $LOG  1> /dev/null
echo '3) SEAG02-data_wea ---> sd6-data_wea' 2>&1  |  tee -a $LOG  1> /dev/null
rsync  -a -u -H  -v  /mnt/SEAG02_1/data_wea/ /mnt/sd6/data_wea 2>&1  |  tee -a $LOG  1> /dev/null
echo '4) sd6-data_wea--> SEAG02-data_wea' 2>&1  |  tee -a $LOG  1> /dev/null
rsync  -a -u -H  -v  /mnt/sd6/data_wea/ /mnt/SEAG02_1/data_wea 2>&1  |  tee -a $LOG  1> /dev/null
#echo '5) SEAG02-data_wea_bckp ---> sd6-data_wea_bckp' 2>&1  |  tee -a $LOG  1> /dev/null
#rsync  -a -u -H  -v  /mnt/SEAG02_1/data_wea_bckp/ /mnt/sd6/data_wea_bckp 2>&1  |  tee -a $LOG  1> /dev/null
#echo '6) sd6-data_wea_bckp--> SEAG02-data_wea_bckp' 2>&1  |  tee -a $LOG  1> /dev/null
#rsync  -a -u -H  -v /mnt/sd6/data_wea_bckp/ /mnt/SEAG02_1/data_wea_bckp 2>&1  |  tee -a $LOG  1> /dev/null
echo '7) sd6-data_wea--> SEAG04-data_wea' 2>&1  |  tee -a $LOG  1> /dev/null
rsync  -a -u -H  -v  /mnt/sd6/data_wea/ /media/schipani3/SEAG04/temp_hsales847/data_wea 2>&1  |  tee -a $LOG  1> /dev/null
echo '8)  SEAG04-data_wea --> sd6-data_wea' 2>&1  |  tee -a $LOG  1> /dev/null
rsync  -a -u -H  -v  /media/schipani3/SEAG04/temp_hsales847/data_wea/ /mnt/sd6/data_wea  2>&1  |  tee -a $LOG  1> /dev/null
echo '9) tc1-dpago --> tc11-dpago ' 2>&1  |  tee -a $LOG  1> /dev/null
rsync  -a -u -H  -v  /media/truecrypt1/dropbox_pago/ /media/truecrypt11/dropbox_pago 2>&1  |  tee -a $LOG  1> /dev/null
echo '10) tc11-dpago --> tc1-dpago' 2>&1  |  tee -a $LOG  1> /dev/null
rsync  -a -u -H  -v  /media/truecrypt11/dropbox_pago/ /media/truecrypt1/dropbox_pago 2>&1  |  tee -a $LOG  1> /dev/null
#sudo mount -o bind,remount,rw /media/truecrypt2
#rsync -r -a  -v -H --delete  /media/truecrypt1/ /media/truecrypt2 2>&1  |  tee -a $LOG  1> /dev/null
#sudo mount -o bind,remount,ro /media/truecrypt2
#s3cmd sync -H -v -r --delete-removed /media/truecrypt2/dropbox_pago/Dropbox/    s3://d-root/gotacaja/ 2>&1  |  tee -a $LOG  1> /dev/null
}

INIT
CABEC
LOGGER
PRG | pv
TRAILER


#EOL
