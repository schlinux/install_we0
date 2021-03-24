#!/usr/bin/env bash

CABEC_27_LOGGER()
{
  type
 # Variaveis basicas do prg
 # a partir de 20081927nn
 #  readonly PRGR='27_logger_v1'
 #  readonly VERSAO='V200824av1-BETA'
 #readonly ASSINATURA='#we0_2008190934a_logger_function'
 #readonly VTIPO=' Funcoes de criacao de log de sistema '
 #readonly VMODO=' Modo: prg stand-alone - nao-interativo - local '
 #readonly VOBS=' observacoes opcionais '
# Selecionar o modo: (a partir de V150319n)
# OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
 #readonly VINTERA="ALFA"
# OPCAO BRAVO: INTERATIVO - MODO TEXTO:
# readonly VINTERA="BRAVO"
# OPCAO CHARLIE: INTERATIVO - MODO GRAFICO:
# readonly VINTERA="CHARLIE"
#instalar em /opt/<user>/scripts/<ano>/<nomeprg>
#link simbolico em /usr/local/bin
}

function LOGGER_INI() #cria cabecalho do log file generico
{
  local readonly DIRLOG=~/log/${NAMERS[1]}
  function CRIADIR()
  {
    if [[ ! -e $1 ]]; then
      mkdir $1
    elif [[ ! -d $1 ]]; then
      echo "$1 already exists but is not a directory" 1>&2
    fi
     return  $?
  }
  function NOMEAR()
   {
      readonly local LOG=$1/${NAMERS[1]}_`date +%Y-%m-%d-%H%M`_$$.log
      echo ${LOG}
    }

  function PRINTAR ()
  {
    readonly local INICIO=`date +%d/%m/%Y-%H:%M:%S`
        #CRIA O ARQUIVO DE LOGS
    echo " //JOB " >> $1
    echo " " >> $1
    echo "PRG: "${NAMERS[1]}" - VERSAO: "${NAMERS[2]}  >> $1
    echo ${NAMERS[4]}  >> $1
    echo " LOG FILE EM: "$1
    echo "|-----------------------------------------------" >> $1
    echo " Prg iniciado em $INICIO" | tee -a $1
    echo "|-----------------------------------------------" >> $1
  }
 readonly LOG=$(NOMEAR ${DIRLOG}) #constante global
 CRIADIR ${DIRLOG}
 PRINTAR ${LOG}
}

function LOGGER_FIM()
{
 readonly local FINAL=`date +%d/%m/%Y-%H:%M:%S`
 echo "|-----------------------------------------------" >> $LOG
 echo " Prg finalizado em $FINAL" | tee -a $LOG
 echo "|-----------------------------------------------" >> $LOG
 echo " " >> $LOG
 echo " " >> $LOG
}
#EOL
