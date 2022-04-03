## KUB 30: Углубленная настройка Helm

1. Задеплойте чарт из предыдущего задания с именем релиза local-chart в namespace helm.
2. Измените количество реплик до 4 в чарте.
3. Задеплойте изменения с помошью helm в local-chart в namespace helm.
4. Откатите релиз local-chart до первой ревизии с помощью helm (чтобы автопроверка корректно отработала у вас должно быть не больше 2х ревизий)
5. Подождите, пока все реплики будут уничтожены (в живых должен остаться только 1 под!). 

```
kubectl create namespace helm

## Установите nginx-ingress контроллер
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml

## Installing Helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

## скачиваем готовый helm
git clone https://gitlab.rebrainme.com/kubernetes_users_repos/1332/kub-29.git
helm template --namespace=helm ./local-chart/
helm upgrade --install local-chart --namespace=helm ./local-chart/

 helm history local-chart -n helm
 kubectl get po -n helm
 
## меняем replicaCount в values.yaml на 4
helm template --namespace=helm ./local-chart/
helm upgrade --install local-chart --namespace=helm ./local-chart/
helm history local-chart -n helm
kubectl get po -n helm

## Откатываем релиз local-chart до первой ревизии
helm rollback local-chart 1 -n helm
kubectl get po -n helm


## Если хотим через зависимость поставить nginx-ingress контроллер
https://stackoverflow.com/questions/60749509/custom-helm-chart-helm-dep-update-fails-with-error-stable-nginx-ingress-chart

git clone https://github.com/helm/charts.git
cp -r charts/stable/nginx-ingress /path/to/acmes-parent-dir/
## Then you can use a relative reference to the local directory:

dependencies:
- name: nginx-ingress
  version: "1.34"
  repository: "file://../nginx-ingress"



```

```
## Установка через helm nginx-ingress контроллер (попадает в релиз)
https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-helm/
```

https://helm.sh/docs/helm/helm_history/

https://stackoverflow.com/questions/60749509/custom-helm-chart-helm-dep-update-fails-with-error-stable-nginx-ingress-chart

https://github.com/helm/charts/tree/master/stable



