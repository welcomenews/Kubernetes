KUB 22: Управление входящими соединениями — ingress

1. Установите nginx-ingress контроллер в namespace ingress-nginx
2. Проверьте какой IP адрес получил service LoadBalancer в namespace ingress-nginx
3. Создайте DNS запись: ${domain name}, которая указывает на IP адрес из 2ого шага.
4. Создайте deployment с nginx nginx-dp в namespace default.
5. Создайте сервис для nginx-dp с именем svc-internal в namespace default с типом ClusterIP.
6. Создайте ingress nginx-ingress в namespace default для доменного имени ${domain name}.

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml

kubectl apply -f ./deployment_nginx.yaml

curl -X POST "https://api.cloudflare.com/client/v4/zones/9152ec3c08b1a4faeaa95353a929fcc5/dns_records" -H "Authorization: Bearer dfg..." -H "Content-Type:application/json" --data '{"type":"A","name":"ingress.d6315.task22.rbr-kubernetes.com","content":"157.245.18.47","proxied":false}'


kubectl apply -f ./ingress_nginx.yaml

kubectl get pods -A
kubectl get svc -A
kubectl get deploy -A

```

https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/

https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/

https://docs.google.com/spreadsheets/d/16bxRgpO1H_Bn-5xVZ1WrR_I-0A-GOI6egmhvqqLMOmg/edit#gid=1612037324

https://kubernetes.io/docs/concepts/services-networking/ingress/

https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/nginx-configuration/configmap.md

