## 

1. Установите в kubernetes кластер базу данных mysql.
2. Установите в kubernetes кластер cert-manager & nginx-ingress-controller.
3. Установите в kubernetes кластер Prometheus стек для мониторинга состояния кластера (должен быть доступен по https)
4. Установите в kubernetes кластер EFK стек для сбора логов с контейнеров (должен быть доступен по https)
5. Напишите хельм чарт для wordpress блога - который будет:
* использовать образ https://hub.docker.com/_/wordpress
* создавать deployment для wordpress с количеством реплик 1
* подключать директорию uploads с внешнего nfs сервера (будет вам выдан)
* шифровать секретные env-переменные для подключения к базе данных
* создавать ingress для доступа к wordpress
6. Создайте репозиторий в https://gitlab.rebrainme.com/kubernetes_users_repos/<your_gitlab_id>/ и разместите там:
* gitlab-ci.yml - настройки для деплоя вашего хельм чарта в dev / prod окружения
* helm чарт для wordpress приложения
7. в директории internal разместить все манифесты (или чарты), которые вы использовали для запуска mysql базы и nfs provisioner'а

```
## NFS server
## на всех нодах 
sudo apt-get update
sudo apt-get install nfs-common

## на ноде nfs
sudo mkdir -p /opt/nfs/kubernetes/uploads/
sudo chmod 777 /opt/nfs/kubernetes/
sudo chmod 777 /opt/nfs/kubernetes/uploads/

## на ноде1
git clone https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner
или
https://gitlab.rebrainme.com/kubernetes_users_repos/1332/kub-20.git

sed -i'' "s/namespace:.*/namespace: provisioner/g" ./deploy/rbac.yaml ./deploy/deployment.yaml
kubectl create ns provisioner

kubectl apply -f deploy/rbac.yaml

## редактируем IP от nfs
vim deploy/deployment.yaml
kubectl apply -f deploy/deployment.yaml

## меняем имя если нужно
vim deploy/class.yaml
kubectl apply -f deploy/class.yaml

## меняем имя, размер и наймспайс если нужно
vim deploy/test-claim.yaml
kubectl apply -f deploy/test-claim.yaml

1.
## Секрет для mysql
kubectl apply -f mysql-secret.yaml

kubectl apply -f mysql-deployment.yaml

2.
## Установите nginx-ingress контроллер в namespace ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
kubectl -n ingress-nginx get svc


## cert-manager
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.1.0/cert-manager.yaml
## необходимо создать новый clusterIssuer, который будет выписывать сертификаты через letsencrypt
kubectl apply -f ./sert_manager_nginx.yaml

3.
## install helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

## установка kube-prometheus-stack в кластер
kubectl create ns monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm  pull prometheus-community/kube-prometheus-stack
tar zxf kube-prometheus-stack-34.9.0.tgz
rm kube-prometheus-stack-34.9.0.tgz
cd kube-prometheus-stack
cp values.yaml values.dev.yaml
## Включаем grafana, alertmanager, prometheus
vim values.dev.yaml
## В prometheus домен ставлю - prometheus.final.rbr-kubernetes.com
... добавляем аннотации basic authentication в ingress как в kub-34/values.kibana.yaml
## install chart
helm -n monitoring upgrade --install prometheus-stack -f values.dev.yaml ./

kubectl get ing -n monitoring

##  На что DNS ставить ???
## Делаем DNS запись
curl -X POST "https://api.cloudflare.com/client/v4/zones/9152ec3c08b1a4faeaa95353a929fcc5/dns_records" -H "Authorization: Bearer dfg..." -H "Content-Type:application/json" --data '{"type":"A","name":"prometheus.final.rbr-kubernetes.com","content":"157.245.18.47","proxied":false}'

## Получение сертификата.
kubectl apply -f ./prometheus.yaml

## kubectl apply -f ./podmonitor.yaml  ## Проверит нужен ли он (32) !!! Вроде бы не надо.

?????????????????????????????

4.
kubectl create namespace logging

##  На что DNS ставить ???
## Добавляем DNS запись
curl -X POST "https://api.cloudflare.com/client/v4/zones/915..../dns_records" -H "Authorization: Bearer r6E...." -H "Content-Type:application/json" --data '{"type":"A","name":"ingress.06806.task34.rbr-kubernetes.com","content":"134.209.135.50","proxied":false}'

## Install elastic
helm repo add elastic https://helm.elastic.co
helm pull elastic/elasticsearch
tar zxf elasticsearch-7.17.3.tgz
cp elasticsearch/values.yaml values.elastic.yaml
vim values.elastic.yaml
...
helm -n logging upgrade --install elastic -f values.elastic.yaml ./elasticsearch
 
## Install fluent-bit
helm repo add fluent https://fluent.github.io/helm-charts
helm pull fluent/fluent-bit
tar zxf fluent-bit-0.19.23.tgz
cp fluent-bit/values.yaml values.fb.yaml
vim values.fb.yaml
# отключаем testFramework:
...
helm -n logging upgrade --install fluent-bit -f values.fb.yaml ./fluent-bit
 
## Настройте basic authentication
htpasswd -c auth kibana
...
kubectl create secret generic basic-auth --from-file=auth

## Install kibana
helm repo add bitnami https://charts.bitnami.com/bitnami
helm pull elastic/kibana
tar zxf kibana-7.17.3.tgz
cp kibana/values.yaml values.kibana.yaml
vim values.kibana.yaml
... добавляем аннотации basic authentication в ingress
helm -n logging upgrade --install kibana -f values.kibana.yaml ./kibana

kubectl get ing -A




```

8D4CB7DD9C90DF356FEE7C288287186E07AB7D5D

"id":"921244ef4155e95bee398065fbe6a8f7"  prometheus.final.rbr-kubernetes.com


