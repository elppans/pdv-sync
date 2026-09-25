#!/bin/bash

ARQUIVO="/Zanthus/Zeus/pdvJava/CliSiTef.ini"
SECAO="[Geral]"
LINHA="IdentificaMensagens=1"

# Verifica se o arquivo existe
if [ ! -f "$ARQUIVO" ]; then
    echo "ERRO: arquivo $ARQUIVO não encontrado."
    exit 1
fi

# Verifica se a seção [Geral] existe
if ! grep -qx "\[Geral\][[:space:]]*" "$ARQUIVO"; then
    echo "Seção $SECAO não encontrada. Nada a fazer."
    exit 0
fi

# Verifica se dentro da seção [Geral] a linha exata já existe
# (procura entre [Geral] e o próximo [Seção])
if awk -v linha="$LINHA" '
    /^\[Geral\][[:space:]]*\r?$/ { dentro=1; next }
    /^\[.*\]/                     { dentro=0 }
    dentro { sub(/\r$/, ""); if ($0 == linha) achou=1 }
    END { exit !achou }
' "$ARQUIVO"; then
    echo "OK: $LINHA já existe na seção $SECAO."
    exit 0
fi

# Não existe: faz backup e adiciona logo abaixo de [Geral]
cp -p "$ARQUIVO" "$ARQUIVO.bak"

sed -i "/^\[Geral\][[:space:]]*\r\?$/a $LINHA" "$ARQUIVO"

echo "Linha '$LINHA' adicionada na seção $SECAO. Backup em $ARQUIVO.bak"

