#!/bin/bash

# Deploy do Bookinfo

echo "*** Realizando Deploy do Bookinfo ***"
kubectl apply -f bookinfo.yaml 
echo "*** Services (ns=default) ***"
kubectl get svc
echo "*** Pods (ns=default) ***"
kubectl get pods --watch

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

echo "*** Inicializando Addons ***"
cd istio-1.13.3
kubectl apply -f samples/addons
kubectl get pods --namespace=istio-system
cd ..

# Deploy do Destination Rule / Config Map

kubectl apply -f destination-rule.yaml
kubectl apply -f user-route.yaml
#kubectl apply -f config-map.yaml

echo "$GATEWAY_URL"
echo "*** Acesso: http://$GATEWAY_URL/productpage ***"
