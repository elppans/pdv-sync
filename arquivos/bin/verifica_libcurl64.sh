#!/bin/bash

# remoção das bibliotecas libcurl*.so*
rm -rfv /Zanthus/Zeus/pdvJava/libcurl*.so
rm -rfv /Zanthus/Zeus/lib_u64/libcurl*.so
rm -rfv /Zanthus/Zeus/path_comum_servidor/ZArqConfig/libcurl*.so
rm -rfv /Zanthus/Zeus/path_comum_servidor/so_u64/libcurl*.so
rm -rfv /Zanthus/Zeus/path_comum/ZArqConfig/libcurl*.so
rm -rfv /Zanthus/Zeus/path_comum/so_u64/libcurl*.so
rm -rfv /Zanthus/Zeus/path_comum_temp/ZArqConfig/libcurl*.so
rm -rfv /Zanthus/Zeus/path_comum_temp/so_u64/libcurl*.so

ldconfig

# verificar se ainda existem arquivos correspondentes
# Caso os comandos não retornem nenhum arquivo, significa que não foram 
# encontradas bibliotecas libcurl.so* nos respectivos diretórios.

find /Zanthus/Zeus/pdvJava -maxdepth 1 -name "libcurl*.so"
find /Zanthus/Zeus/lib_u64 -maxdepth 1 -name "libcurl*.so"
find /Zanthus/Zeus/path_comum_servidor/ZArqConfig -maxdepth 1 -name "libcurl*.so"
find /Zanthus/Zeus/path_comum_servidor/so_u64 -maxdepth 1 -name "libcurl*.so"
find /Zanthus/Zeus/path_comum/ZArqConfig -maxdepth 1 -name "libcurl*.so"
find /Zanthus/Zeus/path_comum/so_u64 -maxdepth 1 -name "libcurl*.so"
find /Zanthus/Zeus/path_comum_temp/ZArqConfig -maxdepth 1 -name "libcurl*.so"
find /Zanthus/Zeus/path_comum_temp/so_u64 -maxdepth 1 -name "libcurl*.so"
