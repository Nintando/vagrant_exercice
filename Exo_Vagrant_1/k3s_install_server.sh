#!/bin/bash

curl -sfL https://get.k3s.io/ | sh -s - server --write-kubeconfig-mode 644
for i in $(seq 1 20); do
  if [ -f /var/lib/rancher/k3s/server/node-token ]; then break; fi
  sleep 2
done
cp /var/lib/rancher/k3s/server/node-token /vagrant/k3s_token
cp /etc/rancher/k3s/k3s.yaml /vagrant/kubeconfig
sed -i 's/127.0.0.1/192.168.56.110/g' /vagrant/kubeconfig || true