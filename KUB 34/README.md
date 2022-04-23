## KUB 34: Сбор логов в кластере Kubernetes




```
## Helm
...


## Установите nginx-ingress контроллер в namespace ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
kubectl -n ingress-nginx get svc

kubectl create namespace logging

## Install elastic
helm repo add elastic https://helm.elastic.co
helm pull elastic/elasticsearch
tar zxvf elasticsearch-7.17.3.tgz
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
...
helm -n logging upgrade --install fluent-bit -f values.fb.yaml ./fluent-bit
 
## Install kibana
helm repo add bitnami https://charts.bitnami.com/bitnami
helm pull elastic/kibana
tar zxf kibana-7.17.3.tgz
cp kibana/values.yaml values.kibana.yaml
vim vim values.kibana.yaml
...
helm -n logging upgrade --install kibana -f values.kibana.yaml ./kibana

kubectl get ing -A

## Добавляем DNS запись
curl -X POST "https://api.cloudflare.com/client/v4/zones/915..../dns_records" -H "Authorization: Bearer r6E...." -H "Content-Type:application/json" --data '{"type":"A","name":"ingress.06806.task34.rbr-kubernetes.com","content":"134.209.135.50","proxied":false}'

## Заходим, проверяем на указанный хост 
http://ingress.06806.task34.rbr-kubernetes.com


```









https://itsecforu.ru/2020/02/18/%E2%98%B8%EF%B8%8F-%D0%BA%D0%B0%D0%BA-%D0%BD%D0%B0%D1%81%D1%82%D1%80%D0%BE%D0%B8%D1%82%D1%8C-kubernetes-ingress-controller-%D0%B4%D0%BB%D1%8F-%D0%B0%D1%83%D1%82%D0%B5%D0%BD%D1%82%D0%B8%D1%84%D0%B8/

