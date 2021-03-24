#! /bin/bash 
#

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='12-a4-bckp-rdiff'
VERSAO='V200603av1'
ASSINATURA='#we0_2005210953a_a4-bckp-rdiff'
VTIPO=' RDIFF-BACKUP PERIODICO DIRETORIO GOTACAJA'
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
# Backup rdiff diretorio trabalho Gotacaja mensal dia 13,14 17:40
# 40   17   13,14  *  *  /mnt/sd6/opt/home/schipani3/2020/12-a4_backup-rdiff/12-a4_backup-rdiff_v1.sh  2>  /home/schipani3/log/12-a4-bckp-rdiff/a4-bckp-rdiff_err_$$.log

PRG()
{
DIR=~/log/${PRGR}
if [[ ! -e ${DIR} ]]; then
    mkdir ${DIR}
elif [[ ! -d ${DIR} ]]; then
    echo "${DIR} already exists but is not a directory" 1>&2
fi   


 #VARIAVEIS  
 INICIO=`date +%d/%m/%Y-%H:%M:%S`  
 LOG=$DIR/`date +%Y-%m-%d-%H%M`_$$_${PRGR}.log  
   
 #DEFINA AQUI O DIRETÓRIO QUE SERÁ EFETUADO O BACKUP  
 ORIGEM='/media/truecrypt1/dropbox_pago/'
   
 #DEFINA AQUI O DIRETÓRIO DESTINO  
 DESTINO='/media/truecrypt1/gotacaja_rdiffbkp_mensal/'
 DESTINO2='/media/truecrypt2/gotacaja_rdiffbkp_mensal' # CUIDADO SEM /
 #CRIA O ARQUIVO DE LOGS  
 echo " " >> $LOG  
 echo " " >> $LOG  
 echo "PRG: "${PRGR}" - VERSAO: "${VERSAO} >> $LOG  
 echo "|-----------------------------------------------" >> $LOG  
 echo " Backup iniciado em $INICIO" >> $LOG  
   
   
 #CRIA O BACKUP  
 rdiff-backup  --backup --force --print-statistics -v5  ${ORIGEM} ${DESTINO} | pv   >> $LOG  
 rsync -r -a -v   --progress   --delete ${DESTINO} ${DESTINO2} | pv >> $LOG
  
 FINAL=`date +%d/%m/%Y-%H:%M:%S`  
   
 echo " Backup finalizado em $FINAL" >> $LOG  
 echo "|-----------------------------------------------" >> $LOG  
 echo " " >> $LOG  
 echo " " >> $LOG  
 }

CABEC
PRG 
   
 #FIM DO SCRIPT
