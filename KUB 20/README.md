## KUB 20: Ресурсы для управления подключаемыми томами


1. Установите nfs subdir provisioner в namespace provisioner (обратите внимание, что для монтирования nfs на ноде должен быть установлен пакет nfs-common).
2. Создайте storage class nfs-sc, который будет использовать установленный provisioner.
3. Создайте pvc с именем nfs-data и размером 300Mb в namespace default.
4. Создайте под redis с образом redis:latest, который будет использовать созданный pvc и монтировать его в /data внутри контейнера. Redis должен быть создан в namespace default.


```
## на всех нодах 
sudo apt-get update
sudo apt-get install nfs-common

## на ноде nfs
sudo mkdir -p /opt/nfs/kubernetes/
sudo chmod 777 /opt/nfs/kubernetes/

## на ноде1
git clone https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner
sed -i'' "s/namespace:.*/namespace: provisioner/g" ./deploy/rbac.yaml ./deploy/deployment.yaml
kubectl create ns provisioner

kubectl apply -f deploy/rbac.yaml

## редактируем имя и IP
vim deploy/deployment.yaml
kubectl apply -f deploy/deployment.yaml

## меняем имя
vim deploy/class.yaml
kubectl apply -f deploy/class.yaml

## меняем имя, размер и наймспайс
vim deploy/test-claim.yaml
kubectl apply -f deploy/test-claim.yaml

## меняем имя, папку для монтирования и наймспайс
vim deploy/redis_pod.yaml
kubectl apply -f deploy/redis_pod.yaml

kubectl get -n provisioner po
kubectl get storageclass
kubectl get pvc
kubectl get pv
kubectl get po

```

https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner

https://kubernetes.io/blog/2019/01/15/container-storage-interface-ga/

https://kubernetes.io/docs/concepts/storage/volumes/

https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes

https://kubernetes.io/docs/concepts/storage/persistent-volumes/#claims-as-volumes

