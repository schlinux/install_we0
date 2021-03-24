#!/usr/bin/env bash

CABEC_25_INIT()
{
# Variaveis basicas do prg
# a partir de 150627nn
 local readonly PRGR='25_init_v2'
 local  readonly VERSAO='V200903av1'
 local readonly ASSINATURA='#we0_2008161833a_init_procedure'
 local readonly VTIPO=' Procedure de parametros de seguranca na execucao '
 local readonly VMODO=' Modo: funcao de inclusao - nao-interativo - local '
 local readonly VOBS=' observacoes opcionais '
# Selecionar o modo: (a partir de V150319n)
# OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
 local readonly VINTERA="ALFA"
# OPCAO BRAVO: INTERATIVO - MODO TEXTO:
# readonly VINTERA="BRAVO"
# OPCAO CHARLIE: INTERATIVO - MODO GRAFICO:
# readonly VINTERA="CHARLIE"
#instalar em /opt/<user>/scripts/<ano>/25-init
#link simbolico em /usr/local/bin
}

INIT()
{
# -----------------------------------------------------------------------------
# Safety settings (see https://gist.github.com/ilg-ul/383869cbb01f61a51c4d).
#MAS WAS HERE FUNCTIONAL PROGRAMMING

  function DEBUGGING()
  {
    DEBUG=$1
    if [[ ! -z ${DEBUG} ]]
    then
      set ${DEBUG} # Activate the expand mode if DEBUG is anything but empty.
    else
      DEBUG=""
    fi
  }


  function SECURITY_SET()
  {
    set -o errexit # Exit if command failed.
    set -o pipefail # Exit if pipe failed.
    set -o nounset # Exit if variable not set.
    # Remove the initial space and instead use '\n'.
    IFS=$'\n\t'
  }


  function SCRIPT_LOCATE()
  {
    # -----------------------------------------------------------------------------
    # Identify the script location, to reach, for example, the helper scripts.

    script_path="$0"
    if [[ "${script_path}" != /* ]]
    then
      # Make relative path absolute.
      script_path="$(pwd)/$0"
    fi
  }


  function READONLY_CONSTANTS()
  {
    readonly DEBUG=${DEBUG}
    readonly script_path=${script_path}
    readonly script_name="$(basename "${script_path}")"
    readonly script_folder_path="$(dirname "${script_path}")"
    readonly script_folder_name="$(basename "${script_folder_path}")"
  }


  DEBUGGING ${DEBUG}
  SECURITY_SET
  SCRIPT_LOCATE
  READONLY_CONSTANTS
# =============================================================================
}
