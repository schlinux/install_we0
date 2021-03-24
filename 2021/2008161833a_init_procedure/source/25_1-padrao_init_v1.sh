#!/usr/bin/env bash

CABEC_25()
{
# Variaveis basicas do prg
# a partir de 150627nn
 readonly PRGR='25_1-padrao_init_v1'
 readonly VERSAO='V200818bv1'
 readonly ASSINATURA='#we0_2008161833a_init_procedure'
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
#instalar em /opt/<user>/scripts/<ano>/25-init
#link simbolico em /usr/local/bin
}

SOURCES_25()
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

PRG_25()
{
  echo 'script_path: '${script_path}
  echo 'Teste ' ${script_name} \
        ': Procedure de parametros de seguranca na execucao bem-sucedido!'
}

SOURCES_25 # carga de funcoes - procedures
CABEC_25 # cabecalho de constantes basicas
PRG_25
