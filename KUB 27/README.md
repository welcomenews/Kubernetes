##  KUB 27: Горизонтальное масштабирование

1. Установите metrics server в Kubernetes кластер.
2. Создайте дейплоймент alpine-dp в namespace default, который внутри будет запускать команду dd для копирования данных из /dev/zero в /dev/null.
3. Создайте HorizontalPodAutoScaler hpa-alpine в namespace default, который будет увеличивать количество реплик этого деплоймента при достижении ими cpu usage 20% (обратите внимание, иногда для полноценного сбора статистики нужно подождать до 20 минут).


```
## скачиваем metrics server
wget https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
## правим, добавляем --kubelet-insecure-tls в args:
vim components.yaml

kubectl api-resources
kubectl get apiservices

kubectl apply -f ./alpine_def.yaml
kubectl apply -f ./autoscale_def.yaml

kubectl describe po
kubectl get HorizontalPodAutoscaler
kubectl get deploy
kubectl describe po alpine-dp-754fc48444-rhp2k
kubectl describe node node2
kubectl get podmetrics 

```

https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/

