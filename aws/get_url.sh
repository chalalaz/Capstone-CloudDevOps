#!/usr/bin/env bash
kubectl get service bluegreenlb --output=jsonpath="{.status.loadBalancer.ingress[0]['hostname','ip']}"
