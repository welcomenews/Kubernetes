## KUB 13: Ресурсы Service в Kubernetes

1. Установите metallb в namespace metallb-system
2. Задайте пул адресов для metallb - 10.114.15.0/24
3. Создайте деплоймент httpd-dp в namespace default с образом httpd.
4. Создайте сервис http-svc-int в namespace default с типом ClusterIP, который будет смотреть на поды из третьего пункта.
5. Создайте сервис http-svc-ext в namespace default с типом LoadBalancer, который будет смотреть на поды из третьего пункта.


```
## Создаём metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

## Так же metallb просит выставить параметр strictARP: true в настройках kube-proxy. 
kubectl edit configmap -n kube-system kube-proxy
strictARP: true

kubectl -n metallb-system apply -f cm.yaml
kubectl apply -f ./deploy.yaml
kubectl apply -f ./svc-clusterIP.yaml
kubectl apply -f ./svc-loadBalancer.yam

## Для проверки LoadBalancer
curl -D - -s -o /dev/null http://10.114.15.0

# для проверки ClusterIP
kubectl run -it alpine --image alpine -- sh
curl -v http://http-svc-int


kubectl get svc -o=wide
kubectl get po -o=wide
kubectl get namespaces
kubectl get deployment

```

https://kubernetes.io/docs/concepts/services-networking/service/

https://metallb.universe.tf/installation/

https://metallb.universe.tf/configuration/

https://cloud.redhat.com/learn/topics/kubernetes/




