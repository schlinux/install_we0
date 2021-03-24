#!/usr/bin/env bash

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='19-sshfs'
VERSAO='V2006250533av1'
ASSINATURA='#we0_2005291947a_sshfs'
VTIPO=' Shell script de montagem de sshfs na maq. local. '
VMODO=' Modo: prg stand-alone - nao-interativo - local '
VOBS=' observacoes opcionais '
# Selecionar o modo: (a partir de V150319n)
# OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
VINTERA="ALFA"
# OPCAO BRAVO: INTERATIVO - MODO TEXTO:
# VINTERA="BRAVO"
# OPCAO CHARLIE: INTERATIVO - MODO GRAFICO:
# VINTERA="CHARLIE"
#SEGURANCA
set -euo pipefail
IFS=$'\n\t'
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

PRG()
{
DIR1=user@10.0.0.213:/mnt/winxp/Documents\ and\ Settings/All\ Users/Desktop/schlga410
DIR2=/mnt/sd6/home/schipani3/rede_sshfs1
#killall sshfs 
#sshfs user@10.0.0.213:/mnt/winxp/Documents\ and\ Settings/All\ Users/Desktop/schlga410 '/mnt/sd6/home/schipani3/rede_sshfs1' &
sshfs "${DIR1}"  "${DIR2}"   
exit
# fusermount -u  ${DIR2}' desmonta
}

INIT
CABEC
PRG

#EOL

