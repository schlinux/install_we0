#!/bin/bash

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
PRGR='16-autoexecbat'
VERSAO='V200628av1'
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

PRG()
{
sudo rm -rf /tmp/* &
rm ~/.TrueCrypt-lock-schipani3 &
guake -e byobu & 
19sshfs &
sudo ufw enable 
sudo mount --bind -o ro /mnt/sd6/data_wea_bckp /mnt/sd6/data_wea_bckp
sudo mount -o bind,ro  /media/truecrypt2 /media/truecrypt2
# truecrypt && disown -a && exit &
truecrypt &

}

INIT
CABEC
PRG | pv 

#EOL

