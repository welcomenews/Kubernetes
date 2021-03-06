## KUB-04: Запуск Kubernetes в облаке с помощью terraform

1. Установите terraform, yandex cli и kubectl на подготовленную виртуальную машину под пользователем user
2. Настройте yandex cli для работы с вашим облаком под пользователем user
3. Напишите terraform файл, который будет создавать следующие ресурсы:
* сервисный аккаунт docker с правами push в container registry;
* сервисный аккаунт instances с правами editor для создания виртуальных машин;
* сеть internal с адресацией 10.200.0.0/16, 10.201.0.0/16 и 10.202.0.0/16 в разных зонах доступности;
* Kubernetes-кластер с именем kub-test;
* Kubernetes-кластер должен быть зональный (1 мастер в зоне ru-central1-a, в остальных зонах мастеров нет)
* группа узлов с именем test-group-auto;
* группа узлов должна масштабироваться автоматически с максимальным количеством хостов 3 штуки и минимальным — 2 штуки;
* группа узлов должна находиться в одной зоне доступности (allocation_policy - ru-central1-a)
* Kubernetes-кластер должен поддерживать сетевые политики безопасности (Включается при создании кластера в managed service for kubernetes. Сетевые политики должны поддерживаться сетевым драйвером - например, calico. При включении данной опции в Yandex Cloud - Yandex установит сетевой плагин calico в kubernetes кластер.)
4. Запустите terraform и создайте кластер.
5. Импортируйте конфигурацию для kubectl, используя yandex cli для пользователя user
6. Выполните команду kubectl label nodes --all status=done, для того чтобы добавить всем узлам метку status=done.


```
# Если не срабатывает команда git clone , то выполняем команду 
export GIT_SSL_NO_VERIFY=1

https://gitlab.rebrainme.com/kubernetes_users_repos/1332/kub-04.git

# Install terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# Install yandex cli
curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash

Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && sudo chmod +x kubectl && sudo mv kubectl /usr/local/bin

yc init
terraform init
terraform apply
yc container cluster list
yc container cluster get-credentials kub-test --external
kubectl cluster-info
kubectl get nodes
kubectl label nodes --all status=done

```


https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group#scale_policy

https://cloud.yandex.ru/docs/managed-kubernetes/concepts/release-channels-and-updates

https://cloud.yandex.com/en/docs/managed-kubernetes/api-ref/NodeGroup/

https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart

https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token

https://cloud.yandex.ru/docs/iam/quickstart-sa


