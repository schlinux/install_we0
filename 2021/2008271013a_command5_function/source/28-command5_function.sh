#!/usr/bin/env bash


function CABEC_28-COMMAND5()
{
  # Variaveis basicas do prg
  # a partir de 200819nn
  local readonly PRGR='28-pecmd5_v1'
  local readonly VERSAO='V200827av1-ALFA'
  local readonly ASSINATURA='#we0_2008271013a_pecmd5_function'
  local readonly VTIPO=' Funcao de controle de programas externos ao bash '
  local readonly VMODO=' Modo: funcao stand-alone - nao-interativo - local '
  local readonly VOBS=' observacoes opcionais '
  # Selecionar o modo: (a partir de V150319n)
  # OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
  local readonly VINTERA="ALFA"
}

function READ_ARGUMENTOS_FROM_FILE()
{
  local readonly ARQUIVOARGUMENTO=$1
  # linhas iniciadas com ## sao comentadas
  awk '/^##/{next}{print}'  ${ARQUIVOARGUMENTO}
}

function READ_ARGUMENTO_SEPARATED_EQUAL()
{
   local readonly ARGUMENTO=$1
   local readonly ARQUIVOARGUMENTO=$2
   READ_ARGUMENTOS_FROM_FILE ${ARQUIVOARGUMENTO} | \
    awk  -F= '/^'${ARGUMENTO}'/{print $2}'
}

function READ_ARGUMENTO_SEPARATED_SEMICOLON()
{
  local readonly ARGUMENTO=$1
  local readonly ARQUIVOARGUMENTO=$2
  READ_ARGUMENTOS_FROM_FILE ${ARQUIVOARGUMENTO} | \
    awk  -F ";" '/^'${ARGUMENTO}'/{print $2}'
}

function COMMAND_TRAP1()
{
  # PARAMETROS
  # CMD e' o cmdo a executar
  # FATALERTA eh um parametro MSGFATAL OU MSGALERTA
  # LOGCMD eh um log do comando executado
  local readonly CMD=$1
  local readonly FATALERTA=$2
  local readonly LOGCMD=$3
  trap "echo '*************' >> ${LOGCMD}; \
        echo 'INTERRUPTED!: '${CMD}  >> ${LOGCMD}; \
        echo ${FATALERTA} >> ${LOGCMD};  exit 10" 1 2 3 6
    eval ${CMD} 2>&1>> ${LOGCMD}   || exit $?
  trap - 1 2 3 6
}

function APPEND_LOG()
{
    local readonly LOG=$1
    local readonly MSG=${LOG}" interrompido"
    COMMAND_TRAP1 "tee -a ${LOG} " ${MSG} /dev/stdout
}
