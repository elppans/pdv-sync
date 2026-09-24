#!/bin/env bash

# adicionar um host ao arquivo known_hosts sem precisar acessar o servidor.
# Comando para escanear a chave pública do host e adicioná-la ao arquivo known_hosts
# As funções add_ip_to_known_hosts e remove_ip_from_known_hosts agora verificam se as operações foram bem-sucedidas.
# Se ocorrer algum erro, uma mensagem de erro é exibida e o script é encerrado com o código de saída

#ssh-keyscan -H 10.100.135.83 >> ~/.ssh/known_hosts

# Verifica se o primeiro parâmetro foi fornecido
if [ -z "$1" ]; then
    echo "Você não forneceu nenhum valor."
    exit 1
fi

# Variáveis para o ambiente
IP="$1"
KNOWN_HOSTS_FILE="$HOME/.ssh/known_hosts"

# Exportar variáveis do ambiente
export IP
export KNOWN_HOSTS_FILE

# Função para verificar se o IP está no arquivo known_hosts
check_ip_in_known_hosts() {
    ssh-keygen -F "$IP" &>/dev/null
}

# Função para verificar se a chave é válida
check_key_validity() {
    ssh-keygen -H -F "$IP" &>/dev/null
}

# Função para adicionar o IP ao arquivo known_hosts
add_ip_to_known_hosts() {
    if ! ssh-keyscan -H "$IP" >>"$KNOWN_HOSTS_FILE"; then
        echo "Chave para o IP $IP adicionado com sucesso."
    else
        # echo "Erro ao adicionar o IP $IP ao arquivo known_hosts."
        exit 1
    fi
}

# Função para remover o IP do arquivo known_hosts
remove_ip_from_known_hosts() {
    if ! ssh-keygen -R "$IP"; then
        echo "Chave para o IP $IP removido com sucesso."
    else
        echo "Erro ao remover o IP $IP do arquivo known_hosts."
        exit 1
    fi
}

# Função principal
main() {
    # echo -e "Checando o IP $IP..."
    if check_ip_in_known_hosts; then
        # echo "O IP $IP já está no arquivo known_hosts."
        if ! check_key_validity; then
            echo "A chave para o IP $IP não é válida. Removendo e readicionando."
            remove_ip_from_known_hosts
            add_ip_to_known_hosts
        # else
        #     echo "A chave para o IP $IP é válida."
        fi
    else
        # echo "Adicionando o IP $IP ao arquivo known_hosts."
        add_ip_to_known_hosts
    fi
}

# Executa a função principal
main
