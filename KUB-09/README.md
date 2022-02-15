## KUB-09: Kubernetes Networking

1. Разверните кластер kubernetes на трех нодах, используя конфиг kubespray
* В control plane должны находиться ноды node1 и node2
* Etcd должен быть запущен на нодах node1, node2, node3
* В качестве network plugin выберите flannel
2. Создайте два пода с image: alpine и именем alpine-1 и alpine-2 в namespace default таким образом, чтобы они были постоянно запущены.
3. Получите IP-адреса каждого пода и сохраните их в файл /ip.txt внутри соответствующего пода (IP alpine-1 должен быть сохранен в /ip.txt внутри пода alpine-1. Та же схема и для alpine-2)
4. Зайдите в под alpine-1 и попробуйте выполнить ping второго пода alpine (alpine-2).

```
## На ноде1
git clone https://github.com/kubernetes-sigs/kubespray
или
https://gitlab.rebrainme.com/kubernetes_users_repos/1332/kub-09.git

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
container_manager: containerd
network_plugin: flannel
kubeconfig_localhost: true

## Заходим в inventory/kuber/group_vars/etcd.yaml
etcd_deployment_type: host

ansible-playbook -i inventory/kuber/hosts.yaml --become --become-user=root cluster.yml

sudo kubectl get nodes

## Install crictl
VERSION="v1.23.0"
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
sudo tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
rm -f crictl-$VERSION-linux-amd64.tar.gz
sudo crictl ps

sudo kubectl run alpine-1 --image=alpine -- ping 8.8.8.8
sudo kubectl run alpine-2 --image=alpine -- ping 8.8.8.8
sudo kubectl get po
sudo crictl ps

## зоходим на alpine-1
sudo crictl exec -it b28ec463f69bb sh
# ip a
# touch /ip.txt
# echo IP >  /ip.txt
# ping IP-alpine-2

## зоходим на alpine-2
sudo crictl exec -it 67cbd8a70afbb sh
# ip a
# touch /ip.txt
# echo IP >  /ip.txt
# ping IP-alpine-1

```

https://github.com/kubernetes-sigs/cri-tools

https://github.com/kubernetes-sigs/cri-tools/blob/master/docs/crictl.md

https://blog.scottlowe.org/2013/09/04/introducing-linux-network-namespaces/

https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/

https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/

https://blog.laputa.io/kubernetes-flannel-networking-6a1cb1f8ec7c

https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/#tuning-autoscaling-parameters






