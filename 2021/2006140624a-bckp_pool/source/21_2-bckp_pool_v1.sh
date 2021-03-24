#!/usr/bin/env bash

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='21_2-bckp_pool_v1'
VERSAO='V200826v1-BETA'
ASSINATURA='#we0_2005210953a_a4-bckp-rdiff'
VTIPO=' RSYNC INCREMENTAL-BACKUP PERIODICO (diario-semanal) DIRETORIO GOTACAJA '
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
#  RSYNC INCREMENTAL-BACKUP PERIODICO (diario-semanal) DIRETORIO GOTACAJA  12:50PM-2:50AM
# 50   2,12   *  *  *  /mnt/sd6/home/schipani3/.Programas_iniciar/21-bckp_pool/21_2-bckp_pool.sh 2>  /mnt/sd6/home/schipani3/log/crontab_errors/21_2-bckp_pool_err_$$.log
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


FASE1()
{
 
echo 'FASE 1' >> $LOG    
 #CRIA O BACKUP  
 # BKP LOCAL LOGICO 
  
# CORRE ARRAY PATROT
 i=0
# echo 'nr loop='${#PATROT[@]}
while [ $i -lt ${#PATROT[@]} ]
  do
    i=`expr $i + 1` 
    CRIAPATROT
  done

#rm -rf ${PATROT[10]} | pv >> $LOG
#mv ${PATROT[9]} ${PATROT[10]}  >> $LOG
#mv ${PATROT[8]} ${PATROT[9]}|  >> $LOG
#mv ${PATROT[7]} ${PATROT[8]}|  >> $LOG
#mv ${PATROT[6]} ${PATROT[7]}|  >> $LOG
#mv ${PATROT[5]} ${PATROT[6]}|  >> $LOG
#mv ${PATROT[4]} ${PATROT[5]}|  >> $LOG
mv ${PATROT[3]}  ${PATROT[4]}  >> $LOG   2>&1
mv ${PATROT[2]} ${PATROT[3]} >> $LOG 2>&1
mv ${PATROT[1]} ${PATROT[2]} >> $LOG 2>&1
echo 'rsync -aH --delete   --link-dest='${PATROT[2]}'  '${ORIGEM}'/ '${PATROT[1]}'/' >> $LOG
rsync -aH --delete  --link-dest=${PATROT[2]} ${ORIGEM}/  ${PATROT[1]}/  2>&1  |  tee -a $LOG  1> /dev/null

echo "|-----------------------------------------------" >> $LOG 
}


FASE2()
{
echo 'FASE 2' >> $LOG  
sudo mount -o bind,remount,rw /media/truecrypt2 2>&1  |  tee -a $LOG  1> /dev/null
echo 'rsync -aH   --delete '  ${DESTINO1}'/ '${DESTINO2}'/' >> $LOG  
rsync -aH   --delete ${DESTINO1}/ ${DESTINO2}/ 2>&1  |  tee -a $LOG  1> /dev/null
echo 'rsync -aH   --delete '${ORIGEM}'/ ' ${DESTINO3}'/' >> $LOG
rsync -aH   --delete ${ORIGEM}/ ${DESTINO3}/ 2>&1  |  tee -a $LOG  1> /dev/null
sudo mount -o bind,remount,ro /media/truecrypt2  2>&1  |  tee -a $LOG  1> /dev/null
}

CRIAPATROT()
{ 
   DIR=${PATROT[$i]}
#   echo $DIR
#  echo $i
# read a
   if [[ ! -e ${DIR} ]]; then
     mkdir ${DIR}
     elif [[ ! -d ${DIR} ]]; then
     echo "${DIR} already exists but is not a directory" >> $LOG 1>&2
   fi   
}


PRG ()
{
#VARIAVEIS  
 INICIO=`date +%d/%m/%Y-%H:%M:%S`  
 #PREFIXO DE DIRETORIO TEMPORARIO
 #DEFINA AQUI O DIRETÓRIO QUE SERÁ EFETUADO O BACKUP  
 ORIGEM='/media/truecrypt1/dropbox_pago'  # CUIDADO SEM /
   
 #DEFINA AQUI O DIRETÓRIO DESTINO  
 DESTINO1='/media/truecrypt1/dropbox_backup' # CUIDADO SEM /
 DESTINO2='/media/truecrypt2/dropbox_backup' # CUIDADO SEM /
 DESTINO3='/media/truecrypt2/dropbox_pago'  # CUIDADO SEM /
   
 #CRIA O BACKUP  
 echo "PRG: "${PRGR}" - VERSAO: "${VERSAO} 
 echo $VTIPO 

# DIRETORIOS ROTATIVOS DE HARD LINKS
DIROT1=${DESTINO1}'/dropbox_backup0'
DIROT2=${DESTINO1}'/dropbox_backup1'
DIROT3=${DESTINO1}'/dropbox_backup2'
DIROTN=${DESTINO1}'/dropbox_backup_'`date +%Y-%m-%d-%H%M`_$$
#DIROT4=${DESTINO1}'/dropbox_backup3'
#DIROT5=${DESTINO1}'/dropbox_backup4'
#DIROT6=${DESTINO1}'/dropbox_backup5' 
#DIROT7=${DESTINO1}'/dropbox_backup6'
#DIROT8=${DESTINO1}'/dropbox_backup7'
#DIROT9=${DESTINO1}'/dropbox_backup8'
#DIROT10=${DESTINO1}'/dropbox_backup9'
#
PATROT[1]=${DIROT1}
PATROT[2]=${DIROT2}
PATROT[3]=${DIROT3}
PATROT[4]=${DIROTN}
#PATROT[4]=${DIROT4}
#PATROT[5]=${DIROT5}
#PATROT[6]=${DIROT6}
#PATROT[7]=${DIROT7}
#PATROT[8]=${DIROT8}
#PATROT[9]=${DIROT9}
#PATROT[10]=${DIROT10}


FASE1
FASE2
  
}

INIT
CABEC
LOGGER
PRG | pv
TRAILER


#EOL
