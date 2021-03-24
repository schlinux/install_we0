#!/usr/bin/env bash

CABEC() 
{
# Variaveis basicas do prg
# a partir de 150627nn
 readonly PRGR='25_1-padrao_init_v1'
 readonly VERSAO='V200816av1'
 readonly ASSINATURA=''
 readonly VTIPO=' Prg exemplo de inicializacao - prg funcional '
 readonly VMODO=' Modo: prg stand-alone - nao-interativo - local '
 readonly VOBS=' observacoes opcionais '
# Selecionar o modo: (a partir de V150319n)
# OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
 readonly VINTERA="ALFA"
# OPCAO BRAVO: INTERATIVO - MODO TEXTO:
# readonly VINTERA="BRAVO"
# OPCAO CHARLIE: INTERATIVO - MODO GRAFICO:
# readonly VINTERA="CHARLIE"
}

SOURCES()
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
}

PRG()
{
  echo 'teste'
}

SOURCES # carga de funcoes - procedures
CABEC # cabecalho de constantes basicas
PRG


