#!/usr/bin/env bash
#

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='23-conta_v1'
VERSAO='V200910av1-BETA'
ASSINATURA='we0_2006140624a-bckp_pool'
VTIPO=' FIND  CONTA DIRETORIO CORRENTE'
VMODO=' Modo: prg stand-alone - nao-interativo - local '
VOBS=' '
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

PRG()
{
echo 'PRG '$PRGR ' - VERSAO '$VERSAO
pwd
find . -type f 2> /dev/null | pv | wc -l ; echo ' arquivos'
find . -type d 2> /dev/null | pv | wc -l ; echo ' diretorios'
echo ' Calculando checksum arquivos recentes...'
find . -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -nr | cut -d: -f2- | head | pv | md5sum 
echo ' checksum'

}
INIT
CABEC
PRG

#EOL
