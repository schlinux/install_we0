#! /bin/bash 
#

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='13-w62-bckp-timeshift'
VERSAO='V200522bv1'
ASSINATURA='#w62-2005211519a-bckp-timeshift'
VTIPO=' Shell script de backup Timeshift'
VMODO=' Modo: prg stand-alone - nao-interativo - local '
VOBS=' REQUER SUDO '
# Selecionar o modo: (a partir de V150319n)
# OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
VINTERA="ALFA"
# OPCAO BRAVO: INTERATIVO - MODO TEXTO:
# VINTERA="BRAVO"
# OPCAO CHARLIE: INTERATIVO - MODO GRAFICO:
# VINTERA="CHARLIE"
}
CABEC
#Entrada na crontab:
# Backup rsync do diretorio copia de sistema timeshift mensal dia 14,28 12:21
# 21   12   14,28  *  *  /mnt/sd6/opt/13-w62-bckp-timeshift/13-w62-bckp-timeshift_v1.sh  2>  /home/schipani3/log/13-w62-bckp-timeshift/13-w62-bckp-timeshift_$$.log


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
 ORIGEM='/mnt/sd6/timeshift/'
 #ORIGEM='/mnt/wsdg01_01/data/1202121115_nonfiction_ebooks.bk/' 
 #DEFINA AQUI O DIRETÓRIO DESTINO  
 DESTINO='/mnt/SEAG02_1/timeshift'
 #DESTINO='/tmp/teste'
   
 #CRIA O ARQUIVO DE LOGS  
 echo " " >> $LOG  
 echo " " >> $LOG  
 echo "PRG: "${PRGR}" - VERSAO: "${VERSAO} >> $LOG  
 echo "|-----------------------------------------------" >> $LOG  
 echo " Backup iniciado em $INICIO" >> $LOG  
   
   
 #CRIA O BACKUP 

 sudo rsync -r -a -v   --progress   --delete ${ORIGEM} ${DESTINO} >> ${LOG} 2>   ${DIR}/${PRGR}_`date +%y%m%d%H%M%S`_$$'_err.log'
# (sudo rsync -r -a -v   --progress   --delete --dry-run /mnt/sd6/timeshift/ /mnt/SEAG02_1/timeshift >> ~/log/13-w62-bckp-timeshift/teste.log 2>   ~/log/13-w62-bckp-timeshift_`date +%y%m%d%H%M%S`_$$'_err.log)
 
 #rdiff-backup  --backup --force --print-statistics -v5  ${ORIGEM} ${DESTINO} | pv   >> $LOG  
   
 FINAL=`date +%d/%m/%Y-%H:%M:%S`  
   
 echo " Backup finalizado em $FINAL" >> $LOG  
 echo "|-----------------------------------------------" >> $LOG  
 echo " " >> $LOG  
 echo " " >> $LOG  
   
 #FIM DO SCRIPT
