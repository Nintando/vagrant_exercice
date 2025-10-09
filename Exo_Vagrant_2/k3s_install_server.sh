#!/bin/bash

curl -sfL https://get.k3s.io/ | sh -s - server --write-kubeconfig-mode 644
kubectl create ns httpd-namespace

for i in 1 2 3; do
  export APP_NUM=$i
  export NODE_PORT=$((30000 + i))
  envsubst < /vagrant/web.yml | kubectl apply -f -
done

kubectl apply -f /vagrant/ingress.yml