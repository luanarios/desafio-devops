#!/bin/bash

# Instalação do Istio

curl -L https://istio.io/downloadIstio | sh -
cd istio-1.13.3
echo $PWD
export PATH=$PWD/bin:$PATH
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
cd ..

