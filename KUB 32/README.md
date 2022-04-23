## KUB 32: Мониторинг Kubernetes с помощью Kube Prometheus Stack


1. Установите kube-prometheus-stack в ваш кластер в namespace monitoring.
2. Запустите pod redis-pod в namespace default с двумя контейнерами — redis & redis-exporter.
3. Создайте podmonitor redis-monitor в namespace default, чтобы prometheus собирал данные с redis-exporter.
4. Добавьте в графану dashboard, который будет выводить количество операций в секунду в редисе (вы можете использовать доменное имя, выданное вам в задании для настройки ingress для grafana)


```
## install helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

## Установите nginx-ingress контроллер в namespace ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
kubectl -n ingress-nginx get svc

## установка kube-prometheus-stack в кластер
kubectl create ns monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm  pull prometheus-community/kube-prometheus-stack
tar zxf kube-prometheus-stack-34.9.0.tgz
rm kube-prometheus-stack-34.9.0.tgz
cp kube-prometheus-stack/values.yaml values.dev.yaml
## Включаем grafana, alertmanager, prometheus
vim values.dev.yaml
## install chart
helm -n monitoring upgrade --install prometheus-stack -f values.dev.yaml ./kube-prometheus-stack/

kubectl get ing -n monitoring

kubectl apply -f ./pod-redis.yaml
kubectl apply -f ./podmonitor.yaml

curl -s -D - http://192.168.135.14:9121
curl -s -D - http://192.168.135.14:9121/metrics

## Add DNS records
curl -X POST "https://api.cloudflare.com/client/v4/zones/9152ec3c08b1a4faeaa95353a929fcc5/dns_records" -H "Authorization: Bearer YBb..." -H "Content-Type:application/json" --data '{"type":"A","name":"grafana.54123.task32.rbr-kubernetes.com","content":"206.189.241.69","proxied":false}'
curl -X POST "https://api.cloudflare.com/client/v4/zones/9152ec3c08b1a4faeaa95353a929fcc5/dns_records" -H "Authorization: Bearer YBb..." -H "Content-Type:application/json" --data '{"type":"A","name":"prometheus.54123.task32.rbr-kubernetes.com","content":"206.189.241.69","proxied":false}'


```

https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/values.yaml
