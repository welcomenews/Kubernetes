### KUB 02: Развертывание Kubernetes-кластера с помощью minikube

1. Установите на подготовленную виртуальную машину docker-ce.
2. Установите на подготовленную виртуальную машину minikube.
3. Создайте пользователя с именем kubernetes, из-под которого будет создаваться кластер kubernetes (добавьте его в группу docker).
4. Установите кластер kubernetes, который будет слушать порт 8443.
5. Найдите в выводе команды kubectl cluster-info адрес, на котором запущен kubernetes master, и сохраните его в файл /tmp/master.txt. Адрес должен быть вида: X.X.X.X:YYYYY, то есть сохранить надо IP адрес и порт для подключения.


```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo install minikube /usr/local/bin/

sudo useradd -s /bin/bash -m -G docker kubernetes

# установить kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && chmod +x kubectl && mv kubectl /usr/local/bin

su - kubernetes
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10
kubectl expose deployment hello-minikube --type=NodePort --port=8443
kubectl cluster-info

```

https://kubernetes.io/ru/docs/tasks/tools/install-minikube/#minikube-before-you-begin-2

https://kubernetes.io/ru/docs/setup/learning-environment/minikube/

https://minikube.sigs.k8s.io/docs/start/

https://minikube.sigs.k8s.io/docs/drivers/

