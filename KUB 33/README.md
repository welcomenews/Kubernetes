
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

3.
apiVersion: apps/v1
kind: Deployment
metadata:
  name: whoami-dp
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: whoami
  template:
    metadata:
      labels:
        app: whoami
    spec:
      containers:
        - name: whoami
          image: bee42/whoami:2.2.0
          ports:
          - containerPort: 80
            name: web
          resources:
            requests:
               memory: "128Mi"
               cpu: "200m"
            limits:
               memory: "128Mi"
               cpu: "200m"

kubectl get po

4.
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  name: whoami-monitor
  namespace: default
  labels:
    release: prometheus-stack
spec:
  selector:
    matchLabels:
      app: whoami
  podMetricsEndpoints:
  - port: web

kubectl get PodMonitor
kubectl get podmetrics

5.
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm pull prometheus-community/prometheus-adapter
tar zxf prometheus-adapter-2.8.0.tgz
rm ...
vim ...
helm -n monitoring upgrade --install prometheus-adapter -f values.yaml ./

kubectl -n  monitoring get deploy prometheus-adapter


6.
apiVersion: autoscaling/v2beta1
kind: HorizontalPodAutoscaler
metadata:
  name: hpa-whoami
  namespace: default
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: whoami-dp
  minReplicas: 1
  maxReplicas: 5
  metrics:
  - type: Pod
    pods:
      metricName: http_requests
      targetAverageValue: 2000m
