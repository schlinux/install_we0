#!/usr/bin/env bash

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
 readonly PRGR='26-detoxx_v1'
 readonly VERSAO='V200819av1'
 readonly ASSINATURA='#we0_2008190833a_detoxx'
 readonly VTIPO=' Script de limpeza de espacos e caracteres estranhos em nomes de arquivos  '
 readonly VMODO=' Modo: prg stand-alone - interativo - local '
 readonly VOBS=' observacoes opcionais '
# Selecionar o modo: (a partir de V150319n)
# OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
# readonly VINTERA="ALFA"
# OPCAO BRAVO: INTERATIVO - MODO TEXTO:
 readonly VINTERA="BRAVO"
# OPCAO CHARLIE: INTERATIVO - MODO GRAFICO:
# readonly VINTERA="CHARLIE"
#instalar em /opt/<user>/scripts/<ano>/<nomeprg>
#link simbolico em /usr/local/bin
}

INICIO()
{
#links simbolicos no PATH, ~/.local/bin
#25-init: obrigatorio, seguranca dos executaveis.
 readonly local SRCS=(
  "25-init"
  "25-init"
  "25-init")

function FSOURCES()
{
# CORRE ARRAY
 local i=0
 while [ $i -lt ${#SRCS[@]} ]
  do
    source "${SRCS[i]}"
      i=`expr $i + 1`
  done
}
 FSOURCES "${SRCS[@]}"
 INIT # procedure de parametros de seguranca na execucao
 CABEC
}

PRG()
{

}

INICIO
PRG

#EOL
