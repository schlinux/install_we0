#!/usr/bin/env bash

CABEC_22-DUSA()
{
  # Constantes basicas do prg
  # a partir de 200819nn
  readonly PRGR='22-dusa_v2'       #PRGR
  readonly VERSAO='V200821bv2-BETA'   #VERSAO
  readonly ASSINATURA='#we0_2006160703a_dusa'  #ASSINATURA
  readonly VTIPO=' DU TAMANHO DIR CORRENTE '  #VTIPO
  readonly VMODO='Modo: prg stand-alone - interativo - local'  #VMODO
  readonly VOBS=' observacoes opcionais '  #VOBS
  readonly VINTERA='BRAVO'  #VINTERA
  #declare -rg NAMERS=(\
  #  [0]='0' \   #RESERVADO
  #  [1]='22-dusa_v2' \       #PRGR
  #  [2]='V200821av2-BETA' \  #VERSAO
  #  [3]='#we0_2006160703a_dusa' \ #ASSINATURA
  #  [4]=' DU TAMANHO DIR CORRENTE ' \ #VTIPO
  #  [5]='Modo: prg stand-alone - interativo - local' \ #VMODO
  #  [6]=' observacoes opcionais ' \ #VOBS
  #  [7]='BRAVO')  #VINTERA
  # Exemplo
  # 1- PRGR='25_1-padrao_init_v1'
  # 2- VERSAO='V200818bv1'
  # 3- ASSINATURA='#we0_2008161833a_init_procedure'
  # 4- VTIPO=' Prg exemplo de inicializacao - prg funcional '
  # 5- VMODO=' Modo: prg stand-alone - nao-interativo - local '
  # 6- VOBS=' observacoes opcionais '
  # 7- VINTERA='ALFA'
  # Selecionar o modo: (a partir de V150319n)
  # OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
  # readonly VINTERA="ALFA"
  # OPCAO BRAVO: INTERATIVO - MODO TEXTO:
  # readonly VINTERA="BRAVO"
  # OPCAO CHARLIE: INTERATIVO - MODO GRAFICO:
  # readonly VINTERA="CHARLIE"
}

INIT_22-DUSA()
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

LOGGER_INI_22() #cria cabecalho do log file generico
{
  readonly local DIRLOG=/tmp/${PRGR}
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
      readonly local LOG=$1/${PRGR}_`date +%Y-%m-%d-%H%M`_$$.log
      echo ${LOG}
    }

  function PRINTAR ()
  {
    readonly local INICIO=`date +%d/%m/%Y-%H:%M:%S`
        #CRIA O ARQUIVO DE LOGS
    echo " //JOB " >> $1
    echo " " >> $1
    echo "PRG: "${PRGR}" - VERSAO: "${VERSAO}  >> $1
    echo ${VTIPO}  >> $1
    echo " LOG FILE EM: "$1
    echo "|-----------------------------------------------" >> $1
    echo " Prg iniciado em $INICIO" | tee -a $1
    echo "|-----------------------------------------------" >> $1
  }
 readonly LOG=$(NOMEAR ${DIRLOG}) #constante global
 CRIADIR ${DIRLOG}
 PRINTAR ${LOG}
}

LOGGER_FIM_22()
{
 readonly local FINAL=`date +%d/%m/%Y-%H:%M:%S`
 echo "|-----------------------------------------------" >> $LOG
 echo " Prg finalizado em $FINAL" | tee -a $LOG
 echo "|-----------------------------------------------" >> $LOG
 echo " " >> $LOG
 echo " " >> $LOG
}


PRG_22-DUSA()
{
pwd | tee -a  ${LOG}
du -h -c --max-depth=1 |pv >>  ${LOG}
echo "=================================================="
echo "SUMARIO"
cat ${LOG}
echo "=================================================="
}
INIT_22-DUSA
CABEC_22-DUSA
LOGGER_INI_22
PRG_22-DUSA
LOGGER_FIM_22

#EOL
