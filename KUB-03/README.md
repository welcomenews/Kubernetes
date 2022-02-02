## KUB-03: Развертывание Kubernetes-кластера с помощью kubespray

1. Склонируйте репозиторий с kubespray локально на свою машину.
2. Выставите переменную для генерации локального kubeconfig.
3. Сгенерируйте inventory файл для вашего кластера:
* в control plane должны находиться две первые ноды (node1, node2)
* worker nodes и etcd должны входить все три ноды, которые были вам выданы (node1, node2, node3)
4. Разверните кластер Kubernetes с помощью kubespray


```
git clone https://github.com/kubernetes-sigs/kubespray
или
https://gitlab.rebrainme.com/kubernetes_users_repos/1332/kub-03.git

ssh-copy-id user@NODE-1IP
ssh-copy-id user@NODE-2IP
ssh-copy-id user@NODE-3IP

pip3 install -r requirements.txt
cp -pr inventory/sample inventory/local

# Объявляем IP адреса для нашего кластера
declare -a IPS=(134.122.85.85 134.122.69.63 161.35.28.90)

# запускаем скрипт генерации inventory:
CONFIG_FILE=inventory/local/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# Заходим в group_vars/k8s-cluster и открываем файл k8s-cluster.yaml.
container_manager: docker
kubeconfig_localhost: true

ansible-playbook -i inventory/local/hosts.yaml --become --become-user=root cluster.yml

kubectl get nodes

# А подключиться локально можно, используя kubeconfig, который для нас сгенерировал kubespray:
KUBECONFIG=inventory/local/artifacts/admin.conf kubectl get nodes

```

https://stackoverflow.com/questions/65665128/kubespray-and-problem-with-python-package

https://kubernetes.io/docs/setup/



