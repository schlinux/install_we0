#!/usr/bin/env bash

CABEC_25_INIT() 
{
# Variaveis basicas do prg
# a partir de 150627nn
 local readonly PRGR='25_init_v2'
 # readonly VERSAO='V200817av1'
 #readonly ASSINATURA=''
 #readonly VTIPO=' Procedure de parametros de seguranca na execucao '
 #readonly VMODO=' Modo: prg stand-alone - nao-interativo - local '
 #readonly VOBS=' observacoes opcionais '
# Selecionar o modo: (a partir de V150319n)
# OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
 #readonly VINTERA="ALFA"
# OPCAO BRAVO: INTERATIVO - MODO TEXTO:
# readonly VINTERA="BRAVO"
# OPCAO CHARLIE: INTERATIVO - MODO GRAFICO:
# readonly VINTERA="CHARLIE"
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

