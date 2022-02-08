##  KUB-06: Основы работы с Kubectl

1. Запустите под alpine с командой ping 8.8.8.8 (иначе он будет постоянно останавливаться) в namespace default.
2. Добавьте этому поду label internal=true.
3. Создайте файл /test.tmp внутри контейнера alpine.
4. Освободите любую ноду из кластера от подов — чтобы на ней нельзя было запустить поды и текущие поды также перенеслись на другую ноду.


```
kubectl run alpine --image=alpine -- ping 8.8.8.8
kubectl get po

kubectl label pods alpine internal=true
kubectl get pods --show-labels

kubectl describe po alpine
kubectl get po alpine -o json
kubectl get nodes -o yaml

kubectl exec alpine -- touch /test.tmp
kubectl exec alpine -- ls /

kubectl cordon node2
kubectl drain node2 --ignore-daemonsets

```


https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run

https://kubernetes.io/docs/reference/kubectl/cheatsheet/

https://kubernetes.io/docs/reference/kubectl/overview/

