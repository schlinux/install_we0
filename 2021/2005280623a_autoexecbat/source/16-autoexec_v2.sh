#!/bin/bash

CABEC()
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='16-autoexecbat'
VERSAO='V201029av1'
ASSINATURA='#we0_2005280623a_autoexecbat'
VTIPO=' Shell script de inicializacao do home user'
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

function FGUAKE()
{
 (guake && echo 'fguake OK')  || echo 'ERRO FGUAKE'
}

function F19SSHFS()
{
 (19sshfs &) || echo 'ERRO F19SSHFS'
# ERRO NAO APARECE DEVIDO &
}

function FUFW()
{
  sudo ufw enable || echo 'ERRO FUFW'
}

function FGOOFYS()
{
  local readonly VDROOT=~/d-root
  ([ "$(ls -A ${VDROOT})" ] && echo ${VDROOT}' JAH MONTADO' || (goofys d-root ${VDROOT} && echo ${VDROOT}' MONTADO') ) || echo  'ERRO FGOOFYS: '${VDROOT}
}

function FTRUECRYPT()
{
  rm ~/.TrueCrypt-lock-schipani3 || echo ''
  (truecrypt &) || echo 'ERRO FTRUECRYPT'
}

function FREADONLY()
{
  local readonly VBCKP1=$1
  local readonly VBCKP2=$VBCKP1'/teste.dat'
  if [[ -d ${VBCKP1} ]] 
   then   
    sudo touch ${VBCKP2} && ( sudo rm ${VBCKP2} ; (sudo mount --bind -o ro ${VBCKP1} ${VBCKP1}  && echo ${VBCKP1}' MONTADO R.O.' ))  || echo ${VBCKP1}' JAH EH R.O.'
   else 
    echo ${VBCKP1}' INEXISTENTE'
  fi
}

function FDATAWEA()
{
  FREADONLY '/mnt/sd6/data_wea_bckp' 
}

function FTRUECRYPT2()
{
  FREADONLY '/media/truecrypt2' 
}


PRG()
{
  FGUAKE
  F19SSHFS
  FUFW
  FGOOFYS
  FTRUECRYPT
  FDATAWEA
  FTRUECRYPT2
  #autossh -R 7779:localhost:22 -p 3200 -i ~/.ssh/joomo01.pem ubuntu@34.205.124.111
}


INIT
CABEC
PRG 

#EOL
