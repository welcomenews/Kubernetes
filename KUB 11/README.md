## KUB 11: Базовые ресурсы в Kubernetes

1. Создайте namespace stage.
2. Внутри namespace stage создайте pod redis-kv с двумя контейнерами redis и redis-exporter.
3. Добавьте поду label app=redis.
4. Создайте namespace dev.
5. Внутри namespace dev создайте deployment с именем web-dp с одним контейнером внутри — httpd.
6. Увеличьте количество реплик web-dp до 4.

```
## Создаём ns
kubectl create -f ./stage-ns.yaml
kubectl create -f ./dev-ns.yaml
kubectl get namespaces

##
Правим конфиг для переключения на разные ns
kubectl config set-context stage --namespace=stage --cluster=kubernetes --user=kubernetes-admin
kubectl config set-context dev --namespace=dev --cluster=kubernetes --user=kubernetes-admin
kubectl config view

kubectl config use-context stage
kubectl config current-context
kubectl apply -f ./redis-pod.yaml

kubectl config use-context dev
kubectl config current-context
kubectl apply -f ./httpd-deployment.yaml

kubectl get po
kubectl get rs
kubectl get deployment
kubectl get pods --show-labels

## увеличить количество реплик web-dp до 4 можно либо в файле httpd-deployment.yaml, либо командой ниже.
kubectl scale deployment web-dp --replicas=4


```

https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/

https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/

https://kubernetes.io/docs/tasks/administer-cluster/namespaces/#creating-a-new-namespace

https://kubernetes.io/docs/concepts/workloads/pods/#working-with-pods

https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/

https://ealebed.github.io/posts/2018/%D0%B7%D0%BD%D0%B0%D0%BA%D0%BE%D0%BC%D1%81%D1%82%D0%B2%D0%BE-%D1%81-kubernetes-%D1%87%D0%B0%D1%81%D1%82%D1%8C-4-replicaset/

