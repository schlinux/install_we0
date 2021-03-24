#!/usr/bin/env bash

function CABEC_28_1()
{
# Variaveis basicas do prg
# a partir de 150627nn
 readonly PRGR='28_1-padrao_command5_v1'
 readonly VERSAO='V200903av1'
 readonly ASSINATURA='#we0_2008271013a_command5_function'
 readonly VTIPO=' Prg exemplo da funcao command5 - prg funcional '
 readonly VMODO=' Modo: prg de sistema - interativo - local '
 readonly VOBS=' observacoes opcionais '
# Selecionar o modo: (a partir de V150319n)
# OPCAO ALFA: NAO INTERATIVO - CLI SOMENTE:
 # readonly VINTERA="ALFA"
# OPCAO BRAVO: INTERATIVO - MODO TEXTO:
readonly VINTERA="BRAVO"
# OPCAO CHARLIE: INTERATIVO - MODO GRAFICO:
# readonly VINTERA="CHARLIE"
#instalar em /opt/<user>/scripts/<ano>/25-init
#link simbolico em /usr/local/bin
}

function SOURCES_28_1()
{
#links simbolicos no PATH, ~/.local/bin
#25-init: obrigatorio, seguranca dos executaveis.
 readonly local SRCS=(
  "25-init"
  "28-command5")

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

function CREATE_ARQUIVOARGUMENTO()
{
  local readonly ARQUIVOARGUMENTO=$1
  echo " "> ${ARQUIVOARGUMENTO}
  function OUTPUT_ARQUIVOARGUMENTO()
  {
    local readonly ARGUMENTO=$1
    echo ${ARGUMENTO} >> ${ARQUIVOARGUMENTO}
  }
  OUTPUT_ARQUIVOARGUMENTO '## Arquivo de argumentos exemplo'
  OUTPUT_ARQUIVOARGUMENTO '## COMENTARIOS SAO MARCADOS POR ## NO INICIO DA LINHA'
  OUTPUT_ARQUIVOARGUMENTO \
      '## ; E = SAO DELIMITADORES DE CAMPO PERMITIDO E RESERVADOS'
  OUTPUT_ARQUIVOARGUMENTO "TESTE1='TESTAR1'"
  OUTPUT_ARQUIVOARGUMENTO '## PERMITE META-ARGUMENTOS; VIDE teste7'
  OUTPUT_ARQUIVOARGUMENTO '## FUNCOES USADAS NA LEITURA:'
  OUTPUT_ARQUIVOARGUMENTO '## READ_ARGUMENTO_SEPARATED_EQUAL'
  OUTPUT_ARQUIVOARGUMENTO '## READ_ARGUMENTO_SEPARATED_SEMICOLON'
  OUTPUT_ARQUIVOARGUMENTO '## READ_ARGUMENTOS_FROM_FILE'
  OUTPUT_ARQUIVOARGUMENTO 'TESTE2_1=argumento de texto teste2 ##'
  OUTPUT_ARQUIVOARGUMENTO "TESTE2_2='argumento de texto teste2 - LINHA 2'"
  OUTPUT_ARQUIVOARGUMENTO 'TESTE3_1=SAIDA DE TESTE3_1'
  OUTPUT_ARQUIVOARGUMENTO "TESTE3_2='SAIDA DE TESTE 3_2'"
  OUTPUT_ARQUIVOARGUMENTO 'TESTE3_3=TESTE4_2'
  OUTPUT_ARQUIVOARGUMENTO "TESTE3_4='SAIDA DE TESTE 4_2'"
  OUTPUT_ARQUIVOARGUMENTO 'TESTE_ERRADO=ERRADO TESTE1'
  OUTPUT_ARQUIVOARGUMENTO '## TESTE1 NAO PODE APARECER EH COMENTARIO'
  OUTPUT_ARQUIVOARGUMENTO 'TESTE5_1=TESTE6_1;SAIDA DE TESTE 6_1'
  OUTPUT_ARQUIVOARGUMENTO 'TESTE5_2=TESTE6_2;"SAIDA DE TESTE 6_2"'
  OUTPUT_ARQUIVOARGUMENTO 'teste7;teste8=TESTAR8'
  OUTPUT_ARQUIVOARGUMENTO 'TESTE9;MSG DE TESTE9'
  OUTPUT_ARQUIVOARGUMENTO '## EOL'
}

function PRG_28_1()
{
  CREATE_ARQUIVOARGUMENTO '/tmp/28_1-arquivoargumento.cfg'
  echo 'Teste 28_1-command5: carga de funcao bem-sucedida!'
  echo "Exemplo: COMMAND_TRAP1 'awk {print}  /tmp/28_1-arquivoargumento.cfg' \
        'awk interrompido' /tmp/testelog_$$.log"
  COMMAND_TRAP1 "awk {print}  /tmp/28_1-arquivoargumento.cfg" \
              "awk interrompido" /tmp/testelog_$$.log
  echo "Arquivo de log em 2o plano: "/tmp/testelog_$$.log
  echo "Tecle ENTER p/ ver arquivo"; read a
  cat /tmp/testelog_$$.log
  echo "Tecle ENTER p/ continuar"; read a
  echo "Exemplo: READ_ARGUMENTO_SEPARATED_EQUAL TESTE1 /tmp/28_1-arquivoargumento.cfg"
  echo 'RESULTADO='$(READ_ARGUMENTO_SEPARATED_EQUAL \
                                       'TESTE1' /tmp/28_1-arquivoargumento.cfg)
  echo "Tecle ENTER p/ continuar"; read a
  echo "Exemplo: READ_ARGUMENTO_SEPARATED_SEMICOLON TESTE9 /tmp/28_1-arquivoargumento.cfg"
  echo 'RESULTADO='$(READ_ARGUMENTO_SEPARATED_SEMICOLON \
                                       'TESTE9' /tmp/28_1-arquivoargumento.cfg)
  echo "Tecle ENTER p/ continuar"; read a
  echo "Leitura de multiplas linhas - wildcards:"
  echo "Exemplo: READ_ARGUMENTO_SEPARATED_EQUAL TESTE2 /tmp/28_1-arquivoargumento.cfg"
  READ_ARGUMENTO_SEPARATED_EQUAL TESTE2 /tmp/28_1-arquivoargumento.cfg
  echo "Tecle ENTER p/ continuar"; read a
  echo "Leitura de multiplas linhas - wildcards - meta-argumentos:"
  echo 'RESULTADO=$(READ_ARGUMENTO_SEPARATED_EQUAL \
                                       TESTE5 /tmp/28_1-arquivoargumento.cfg)'
  echo "RESULTADO="$(READ_ARGUMENTO_SEPARATED_EQUAL \
                                       'TESTE5' /tmp/28_1-arquivoargumento.cfg)
  READ_ARGUMENTO_SEPARATED_EQUAL 'TESTE5' /tmp/28_1-arquivoargumento.cfg
  echo "***FIM***"
}

SOURCES_28_1 # carga de funcoes - procedures
CABEC_28_1 # cabecalho de constantes basicas
PRG_28_1

#EOL
