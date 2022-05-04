#!/bin/bash

# Deploy do Bookinfo

echo "*** Realizando Deploy do Bookinfo ***"
kubectl apply -f bookinfo.yaml 
echo "*** Services (ns=default) ***"
kubectl get svc
echo "*** Pods (ns=default) ***"
kubectl get pods

# Deploy do Destination Rule / Config Map

kubectl apply -f destination-rule.yaml
kubectl apply -f config-map.yaml

echo "$GATEWAY_URL"
echo "*** Acesso: http://$GATEWAY_URL/productpage ***"
