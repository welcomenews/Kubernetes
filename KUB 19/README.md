## KUB 19: Аутентификация в registry

1. Создайте secret regcred с данными аутентификации в docker hub.
2. Измените default service account для namespace default, чтобы он использовал указанный секрет для скачивания контейнеров.



```
kubectl create secret docker-registry regcred --docker-server=https://hub.docker.com/ --docker-username=welcomenews --docker-password=123 --docker-email=welcomenews@mail.ru
kubectl apply -f ./nginx_pod.yaml
kubectl apply -f ./servacc.yaml

kubectl get po
kubectl get sa
kubectl describe po nginx
kubectl describe sa default

```

