## KUB 25: Сетевая безопасность в Kubernetes

1. Создайте Network Policy local-http в namespace default, которая будет разрешать подам из namespace default обращаться к подам из этого же namespace по порту 8080.


```
kubectl apply -f pod.yaml
kubectl apply -f network_def_ingress.yaml


## Check
kubectl run test-$RANDOM --namespace=default --rm -i -t --image=alpine -- sh
/ # wget -qO- --timeout=2 http://192.168.104.10:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>

kubectl create namespace foo
kubectl run test-$RANDOM --namespace=foo --rm -i -t --image=alpine -- sh
/ # wget -qO- --timeout=2 http://192.168.104.10:8080
wget: download timed out


kubectl get po -o wide
kubectl get NetworkPolicy

```

https://kubernetes.io/docs/concepts/services-networking/network-policies/

https://github.com/ahmetb/kubernetes-network-policy-recipes

https://itnext.io/cks-exam-series-11-networkpolicies-default-deny-and-allowlist-b2ce4186551f

https://editor.cilium.io/

