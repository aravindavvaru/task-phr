#!/bin/bash

# install kind cluster
# curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
# chmod +x ./kind
# sudo mv ./kind /usr/local/bin/kind
# kind create cluster --config /tmp/config.yaml


#install minikube cluster
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start --force --driver=docker --addons=ingress --cpus=2 --cni=flannel --install-addons=true --kubernetes-version=stable --memory=6g
minikube addons enable ingress


