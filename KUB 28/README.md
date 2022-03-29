## KUB 28: Вертикальное масштабирование

1. Установите metrics server в Kubernetes кластер.
2. Установите vertical autoscaler в ваш Kubernetes кластер
3. Создайте дейплоймент alpine-dp в namespace default, который внутри будет запускать команду dd для копирования файлов из /dev/zero в /dev/null.
4. Задайте деплойменту ограничение ресурсов 200m cpu и 128mb памяти так, чтобы класс QoS у контейнеров получился Guaranteed
5. Создайте VerticalPodAutoscaler vpa-alpine в namespace default с выключенным обновлением деплоймента (updateMode: Off). Обратите внимание, иногда для полноценного сбора статистики нужно подождать до 20 минут.


```
## скачиваем metrics server
wget https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
## правим, добавляем --kubelet-insecure-tls в args:
vim components.yaml

kubectl api-resources
kubectl get apiservices

## Установка vertical autoscaler в кластер
git clone https://github.com/kubernetes/autoscaler/
cd autoscaler
git checkout vpa-release-0.8
./vertical-pod-autoscaler/hack/vpa-up.sh

kubectl apply -f ./alpine_def.yaml
kubectl apply -f ./vpa_def.yaml

kubectl describe po
kubectl get VerticalPodAutoscaler
kubectl get deploy
kubectl describe deploy
kubectl describe VerticalPodAutoscaler

```

https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler

