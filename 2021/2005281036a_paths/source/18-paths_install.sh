#!/bin/bash

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='18-paths_install'
VERSAO='V200626av1'
ASSINATURA='#we0_2005281036a_paths'
VTIPO=' Shell script criador de paths de trabalho de usuario'
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

DIRETS()
{
USERN='schipani3'
USERG='schipani3'
USERY='2020'

# Diretorios de nivel root: sudo mkdir
DIRSU1='/mnt/SEAG05_1'
DIRSU2='/mnt/wsdg01_01'
DIRSU3='/mnt/install_we0'
DIRSU4='/mnt/SEAG02_1'
DIRSU5=${DIRSU1}'/home' 
DIRSU6=${DIRSU1}'/opt' 
DIRSU7=${DIRSU1}'/opt' #VAGO
DIRSU8=${DIRSU6}'/home'
#
PATSU[1]=${DIRSU1}
PATSU[2]=${DIRSU2}
PATSU[3]=${DIRSU3}
PATSU[4]=${DIRSU4}
PATSU[5]=${DIRSU5}
PATSU[6]=${DIRSU6}
PATSU[7]=${DIRSU7}
PATSU[8]=${DIRSU8}


# Diretorios de nivel sub-root: sudo mkdir +chown
DIRUG1=${DIRSU8}'/'${USERN}
DIRUG2=${DIRSU5}'/'${USERN}
DIRUG3=${DIRSU1}'/data'
DIRUG4=${DIRSU2}'/data'
DIRUG5=${DIRSU4}'/data'
#
PATUG[1]=${DIRUG1}
PATUG[2]=${DIRUG2}
PATUG[3]=${DIRUG3}
PATUG[4]=${DIRUG4}
PATUG[5]=${DIRUG5}


# Diretorios de nivel user: mkdir
DIRAR1=${DIRUG2}'/log'
DIRAR2=${DIRUG2}'/Prg_meus'
DIRAR3=${DIRUG2}'/.Programas_iniciar'
DIRAR4=${DIRUG1}'/'${USERY}
DIRAR5=${DIRUG3}'/'${USERY}
DIRAR6=${DIRUG4}'/'${USERY}
DIRAR7=${DIRUG5}'/'${USERY}
DIRAR8=${DIRUG2}'/rede_sshfs1'
DIRAR9=${DIRAR1}'/jobs'
DIRAR10=${DIRAR1}'/crontab_errors'
DIRAR11=${DIRUG2}'/opt'
DIRAR12=${DIRAR11}'/tools'
#
PATAR[1]=${DIRAR1}
PATAR[2]=${DIRAR2}
PATAR[3]=${DIRAR3}
PATAR[4]=${DIRAR4}
PATAR[5]=${DIRAR5}
PATAR[6]=${DIRAR6}
PATAR[7]=${DIRAR7}
PATAR[8]=${DIRAR8}
PATAR[9]=${DIRAR9}
PATAR[10]=${DIRAR10}
PATAR[11]=${DIRAR11}
PATAR[12]=${DIRAR12}
}

CRIAPATSU()
{ 
   DIR=${PATSU[$i]}
  echo $DIR
if [[ ! -e ${DIR} ]]; then
   sudo mkdir ${DIR}
  elif [[ ! -d ${DIR} ]]; then
    echo "${DIR} already exists but is not a directory" 1>&2
fi   
}

CRIAPATUG()
{ 
   DIR=${PATUG[$i]}
  echo $DIR
if [[ ! -e ${DIR} ]]; then
   sudo mkdir ${DIR}
   sudo chown -R ${USERN}:${USERG} ${DIR}
  elif [[ ! -d ${DIR} ]]; then
    echo "${DIR} already exists but is not a directory" 1>&2
fi   
}

CRIAPATAR()
{ 
   DIR=${PATAR[$i]}
   echo $DIR
#  echo $i
# read a
   if [[ ! -e ${DIR} ]]; then
     mkdir ${DIR}
     elif [[ ! -d ${DIR} ]]; then
     echo "${DIR} already exists but is not a directory" 1>&2
   fi   
}

PRG()
{
# CORRE ARRAY PATSU
 i=0
while [ $i -lt ${#PATSU[@]} ]
  do
    i=`expr $i + 1` 
    CRIAPATSU
  done

# CORRE ARRAY PATUG
 i=0
while [ $i -lt ${#PATUG[@]} ]
  do
    i=`expr $i + 1` 
    CRIAPATUG
  done

# CORRE ARRAY PATAR
 i=0
# echo 'nr loop='${#PATAR[@]}
while [ $i -lt ${#PATAR[@]} ]
  do
    i=`expr $i + 1` 
    CRIAPATAR
  done
}
INIT
CABEC
DIRETS
PRG

#EOL

