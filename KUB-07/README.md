## KUB-07: Kubernetes Control Plane

1. Разверните кластер kubernetes на трех нодах, используя конфиг kubespray, подготовленный в 3ем задании:
* В control plane должны находиться ноды node1 и node2
* Etcd должен быть запущен на нодах node1, node2, node3
* Etcd должен быть запущен через docker (настройка по умолчанию в kubespray: inventory/kuber/group_vars/etcd.yaml: etcd_deployment_type: docker)
2. Сохраните бекап etcd на ноде node1 в /tmp/node1.etcd.backup (для подключения к etcd нужно указать сертификаты иначе команда будет висеть)
3. Остановите kube-apiserver на node2 (для этого надо удалить манифест /etc/kubernetes/manifests/kube-apiserver.yaml и рестартануть kubelet: systemctl restart kubelet).
4. Перенастройте kubectl на node2, чтобы он смотрел на ip адрес сервера node1 (поменяйте адрес api-сервера в kubeconfig)
5. Остановите etcd сервер на node2 (имеется ввиду остановить как и любой докер контейнер - используя docker stop)
6. Запустите под alpine с командой ping 8.8.8.8, используя kubectl с node2.


```
## На ноде1
git clone https://github.com/kubernetes-sigs/kubespray
или
https://gitlab.rebrainme.com/kubernetes_users_repos/1332/kub-03.git

ssh-copy-id user@NODE-1IP
ssh-copy-id user@NODE-2IP
ssh-copy-id user@NODE-3IP

pip3 install -r requirements.txt
cp -pr inventory/sample inventory/kuber

# Объявляем IP адреса для нашего кластера
declare -a IPS=(134.122.85.85 134.122.69.63 161.35.28.90)

# запускаем скрипт генерации inventory:
CONFIG_FILE=inventory/kuber/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# Заходим в group_vars/k8s-cluster и открываем файл k8s-cluster.yaml.
container_manager: docker
kubeconfig_localhost: true

## Заходим в inventory/kuber/group_vars/etcd.yaml
etcd_deployment_type: docker

ansible-playbook -i inventory/kuber/hosts.yaml --become --become-user=root cluster.yml

sudo kubectl get nodes

## На ноде2
sudo docker exec -it dacadb3cfb1b sh
# etcdctl snapshot save /tmp/node1.etcd.backup
sudo docker cp dacadb3cfb1b:/tmp/node1.etcd.backup /tmp/

##на ноде2
sudo mv /etc/kubernetes/manifests/kube-apiserver.yaml ~/
sudo systemctl restart kubelet

## Меняем IP на ноде2 в файле config на IP ноды1
sudo vim /root/.kube/config
sudo docker stop 966d24fe002a
sudo kubectl run alpine --image=alpine -- ping 8.8.8.8

```

https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/

https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/

https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#label

