## KUB 21: Запуск Stateful приложений

1. Настройте nfs provisioner по аналогии с предыдущим заданием (не обязательно следовать таким же именам - главное чтобы pv успешно создавались в кластере, для монтирования nfs на ноде должен быть установлен пакет nfs-common).
2. Создайте statefulset с именем kafka-sts в namespace default, который будет запускать 3 пода kafka и создавать для них отдельные pvc kafka-pvc на 1 Гб каждый.


```
## на всех нодах 
sudo apt-get update
sudo apt-get install nfs-common

## на ноде nfs
sudo mkdir -p /opt/nfs/kubernetes/
sudo chmod 777 /opt/nfs/kubernetes/

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

## меняем имя
vim deploy/class.yaml
kubectl apply -f deploy/class.yaml

## настроим zookeeper
vim deploy/zookeeper-cluster.yaml
kubectl apply -f deploy/zookeeper-cluster.yaml

## настроим kafka
vim deploy/kafka-broker.yaml
kubectl apply -f deploy/kafka-broker.yaml


kubectl get -n provisioner po
kubectl get storageclass
kubectl get StatefulSet
kubectl get pvc
kubectl get pv
kubectl get po

```


https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/

https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/

https://github.com/bitnami/bitnami-docker-zookeeper

https://github.com/bitnami/bitnami-docker-kafka

https://github.com/Yolean/kubernetes-kafka

https://medium.com/accenture-the-dock/when-how-to-deploy-kafka-on-kubernetes-b18f5270db63

https://kow3ns.github.io/kubernetes-kafka/manifests/kafka.yaml


