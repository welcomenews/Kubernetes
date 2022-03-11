##  KUB 17: Ресурсы для хранения конфигурации

1. Создайте configmap nginx-conf в namespace default, содержащую конфигурацию для nginx — nginx.conf, в которой указано количество воркеров — 4 штуки.
2. Создайте secret nginx-env в namespace default с переменной AUTH=testpassword.
3. Создайте под nginx в namespace default, который будет монтировать конфигурацию из configmap и добавлять env переменную из secret.

```
kubectl create configmap nginx-conf --from-file=nginx.conf
kubectl apply -f ./work_secret.yaml
kubectl apply -f ./nginx_pod.yaml

kubectl exec -it nginx -- env
kubectl exec -it nginx -- cat /etc/nginx/nginx.conf
kubectl get cm
kubectl get po
kubectl describe po nginx

```

https://ealebed.github.io/posts/2018/знакомство-с-kubernetes-часть-13-конфигмапы-configmap/

https://ealebed.github.io/posts/2018/знакомство-с-kubernetes-часть-14-секреты-secrets/

https://kubernetes.io/docs/concepts/storage/volumes/#using-subpath

https://stackoverflow.com/questions/53338042/are-you-trying-to-mount-a-directory-onto-a-file-or-vice-versa-with-kuberneters
