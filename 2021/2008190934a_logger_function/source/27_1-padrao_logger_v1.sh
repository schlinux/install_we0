#!/usr/bin/env bash

CABEC_27_1()
{
# Constantes basicas do prg
# a partir de 200819nn
readonly  NAMERS=('0'
                  '27_1-padrao_logger_v1'
                  'V200824av1-BETA'
                  '#we0_2008161833a_init_procedure'
                  ' Funcoes de criacao de log de sistema '
                  ' observacoes opcionais '
                  'ALFA')
# Exemplo
 # 1- PRGR='25_1-padrao_init_v1'
 # 2- VERSAO='V200818bv1'
 # 3- ASSINATURA='#we0_2008161833a_init_procedure'
 # 4- VTIPO=' Prg exemplo de inicializacao - prg funcional '
 # 5- VMODO=' Modo: prg stand-alone - nao-interativo - local '
 # 6- VOBS=' observacoes opcionais '
 # 7- VINTERA='ALFA'
# Selecionar o modo: (a partir de V150319n)
# OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
# readonly VINTERA="ALFA"
# OPCAO BRAVO: INTERATIVO - MODO TEXTO:
# readonly VINTERA="BRAVO"
# OPCAO CHARLIE: INTERATIVO - MODO GRAFICO:
}

SOURCES_27_1()
{
#links simbolicos no PATH, ~/.local/bin
#25-init: obrigatorio, seguranca dos executaveis.
source    "25-init"
INIT  # procedure de parametros de seguranca na execucao
# LISTA DE PROCEDURES E FUNCOES A CARREGAR, TODAS LINK SIMBOLICOS
 readonly local SRCS=(
  "25-init"
  "27-logger")

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
}

INICIALIZACAO_27_1()
{
  SOURCES_27_1 # carga de funcoes - procedures
  CABEC_27_1 # cabecalho de constantes basicas
  LOGGER_INI #INICIALIZACAO DO LOG PADRAO
}

PRG_27_1()
{
  echo 'Teste '${NAMERS[1]}': funcao bem-sucedida!' | tee -a $LOG
}
INICIALIZACAO_27_1
PRG_27_1
LOGGER_FIM
#EOL
