#!/bin/bash

# Download do Istio
curl -L https://istio.io/downloadIstio | sh -

# Adicionando istioctl ao PATH - variável de ambiente
cd istio-1.13.3
echo $PWD
export PATH=$PWD/bin:$PATH

# Instalação
istioctl install --set profile=demo -y

# Habilitando Istio no namespace da aplicação (default) - será carregado 1 container para a aplicação e 1 para o proxy
kubectl label namespace default istio-injection=enabled

cd ..