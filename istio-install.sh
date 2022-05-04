#!/bin/bash

# Instalação do Istio

curl -L https://istio.io/downloadIstio | sh -
cd istio-1.13.3
echo $PWD
kubectl apply -f samples/addons
export PATH=$PWD/bin:$PATH
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled

# Configurando Ingress Gateway

echo "*** Configurando Ingress Gateway ***"
kubectl apply -f bookinfo-gateway.yaml
echo "*** Validando Ingress Gateway ***"
istioctl analyze

## Determinando Ingress Port

kubectl get svc istio-ingressgateway -n istio-system
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')

# Habilitando tráfego TCP na porta

export INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].status.hostIP}')

# Obtendo GATEWAY_URL

export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

# Inicializando Addons

kubectl apply -f samples/addons
kubectl get pods --namespace=istio-system