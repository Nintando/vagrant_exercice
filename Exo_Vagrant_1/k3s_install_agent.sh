#!/bin/bash

for i in $(seq 1 20); do
  if [ -f /vagrant/k3s_token ] && nc -z 192.168.56.110 6443; then break; fi
  sleep 2
done
K3S_URL="https://192.168.56.110:6443/"
K3S_TOKEN=$(cat /vagrant/k3s_token)
curl -sfL https://get.k3s.io/ | K3S_URL=$K3S_URL K3S_TOKEN=$K3S_TOKEN sh -
mkdir -p /home/vagrant/.kube
cp /vagrant/kubeconfig /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube
echo "alias k=kubectl" >> /home/vagrant/.bashrc