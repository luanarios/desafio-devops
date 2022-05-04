#!/bin/bash

# Download
curl -L https://istio.io/downloadIstio | sh -

# Adicionando istioctl ao PATH
cd istio-1.13.3
echo $PWD
export PATH=$PWD/bin:$PATH

# Instalação
istioctl install --set profile=demo -y

# Habilitando Istio no namespace da aplicação (default)
kubectl label namespace default istio-injection=enabled

cd ..

