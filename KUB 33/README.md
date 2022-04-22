## KUB 33: Custom Metrics для HPA

1. Установите metrics server в kubernetes кластер.
2. Установите prometheus stack в namespace monitoring.
3. Создайте дейплоймент whoami-dp в namespace default, который внутри будет запускать контейнер whoami.
4. Создайте podmonitor whoami-monitor в namespace default, который будет собирать метрики с подов whoami.
5. Установите prometheus-adapter в namespace monitoring.
6. Создайте HorizontalPodAutoScaler hpa-whoami в namespace default, который будет увеличивать количество реплик данного деплоймента при достижении http_requests более 1ого запроса в секунду..

```
1.
wget https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
## правим, добавляем --kubelet-insecure-tls в args:
vim components.yaml
kubectl apply -f ./components.yaml

kubectl api-resources
kubectl get apiservices

kubectl create ns monitoring

2.
## install helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

## Установите nginx-ingress контроллер в namespace ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm  pull prometheus-community/kube-prometheus-stack
tar zxf kube-prometheus-stack-34.10.0.tgz
rm kube-prometheus-stack-34.10.0.tgz
cp kube-prometheus-stack/values.yaml values.dev.yaml
## Включаем grafana, alertmanager, prometheus
vim values.dev.yaml

## install chart
helm -n monitoring upgrade --install prometheus-stack -f values.dev.yaml ./kube-prometheus-stack/
kubectl get ing -n monitoring

3.
kubectl apply -f ./pods.yaml
kubectl get po

4.
kubectl apply -f ./PodMonitor.yaml
kubectl get PodMonitor
kubectl get podmetrics

5.
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm pull prometheus-community/prometheus-adapter
tar zxf prometheus-adapter-3.2.1.tgz
rm prometheus-adapter-3.2.1.tgz
vim values.yaml

## обратите внимание на переменную metricsRelistInterval — она должна быть равна или больше значения ScrapeInterval в Prometheus, иначе метрики из Kubernetes иногда могут пропадать.
## prometheus: url - prometheus-stack-kube-prom-prometheus.monitoring.kis.im
## важно поменять dnsPolicy на ClusterFirst

helm -n monitoring upgrade --install prometheus-adapter -f values.yaml ./
kubectl -n monitoring get deploy prometheus-adapter

6.
kubectl apply -f ./HorizontalPodAutoscaler.yaml
kubectl get HorizontalPodAutoscaler


```

https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-metrics-apis

https://github.com/kubernetes-sigs/prometheus-adapter

https://github.com/kubernetes-sigs/prometheus-adapter/blob/master/docs/walkthrough.md

https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale



