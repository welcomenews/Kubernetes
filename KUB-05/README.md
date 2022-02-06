## KUB-05: Kubeconfig — подключаемся к кластеру

1. На подготовленной виртуальной машине установите kubectl.
2. Создайте тестовую конфигурацию kubeconfig, содержащую (за основу можно взять конфигурацию, которую сгенерировал kubespray в 3ем задании):
* кластер с именем cluster-old
* кластер с именем cluster-new
* пользователя с именем user
* контекст с именем context-old и использующий кластер cluster-old и пользователя user
* контекст с именем context-new и использующий кластер cluster-new и пользователя user
4. Переключитесь на использование контекста context-new.
5. Положите конфигурационный файл в директорию /root/.kube/ с именем config и отправьте задание на проверку.


```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && sudo chmod +x kubectl && sudo mv kubectl /usr/local/bin
kubectl config use-context context-new
kubectl config get-contexts
mkdir /root/.kube/
vim /root/.kube/config

```

https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/

