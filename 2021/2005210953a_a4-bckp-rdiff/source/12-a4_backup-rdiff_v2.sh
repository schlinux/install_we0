#! /bin/bash 
#

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='12-a4-bckp-rdiff'
VERSAO='V200709bv2-BETA'
ASSINATURA='#we0_2005210953a_a4-bckp-rdiff'
VTIPO=' RDIFF-BACKUP PERIODICO (mensal) DIRETORIO GOTACAJA'
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

#Entrada na crontab:
# Backup rdiff diretorio trabalho Gotacaja mensal dia 13-14 17:40
#40   17   13,14  *  *  /mnt/sd6/opt/home/schipani3/2020/12-a4_backup-rdiff/12-a4_backup-rdiff.sh  2>  ~/log/crontab_errors/12-a4-bckp-rdiff_err_$$.log

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

PRG()
{


 #VARIAVEIS  
 INICIO=`date +%d/%m/%Y-%H:%M:%S`  

 #DEFINA AQUI O DIRETÓRIO QUE SERÁ EFETUADO O BACKUP  
 ORIGEM='/media/truecrypt1/dropbox_pago/'
   
 #DEFINA AQUI O DIRETÓRIO DESTINO  
 DESTINO='/media/truecrypt1/gotacaja_rdiffbkp_mensal/'
 DESTINO2='/media/truecrypt2/gotacaja_rdiffbkp_mensal' # CUIDADO SEM /
 
   
 #CRIA O BACKUP  
 echo "PRG: "${PRGR}" - VERSAO: "${VERSAO} 
 echo $VTIPO 

 rdiff-backup  --backup --force --print-statistics   ${ORIGEM} ${DESTINO} | pv   >> $LOG  
 sudo mount -o bind,remount,rw /media/truecrypt2 >> $LOG  
 rsync -r -a -v -H   --delete ${DESTINO} ${DESTINO2} | pv >> $LOG
 sudo mount -o bind,remount,ro /media/truecrypt2  >> $LOG  
  
 }

INIT
CABEC
LOGGER
PRG 
TRAILER   

 #EOL
