## KUB 29: Основы пакетного менеджера Helm


1. Напишите helm-чарт для сервиса, который будет:
2. создавать один deployment nginx-dp;
3. создавать один сервис nginx-svc, который смотрит на этот деплоймент;
4. создавать ingress nginx-ingress, который смотрит на этот сервис.
5. Задеплойте данный чарт с именем релиза local-chart в namespace helm.


```
## Установите nginx-ingress контроллер
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml

git clone https://gitlab.rebrainme.com/kubernetes_users_repos/1332/kub-29.git
helm template --namespace=helm ./local-chart/
helm upgrade --install local-chart --namespace=helm ./local-chart/


helm list -A
kubectl get ingress -A
kubectl get svc -A
kubectl get pods --show-labels --namespace=helm
kubectl get all --show-labels --namespace=helm

```

https://helm.sh/docs/

