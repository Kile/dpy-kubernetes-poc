#!/bin/bash

COMMAND=$1

case $COMMAND in
  up)
    kubectl apply -f k8s/.
    ;;
  down)
    kubectl delete -f k8s/.
    ;;
  reload)
    kubectl delete -f k8s/.
    kubectl apply -f k8s/.
    ;;
  *)
    echo "Usage: $0 {up|down|reload}"
    exit 1
    ;;
esac