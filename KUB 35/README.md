## KUB 35: Настройка CI/CD в Gitlab для Kubernetes

1. Создайте репозиторий в группе https://gitlab.rebrainme.com/kubernetes_users_repos/<your_gitlab_id>/
2. Склонируйте код приложения расположенный в репозитории и сохраните его в созданный репозиторий в п.1
3. Настройте gitlab-ci в созданном репозитории:
4. необходимо собирать образ контейнера и размещать его в Gitlab Registry.
5. приложение из собранного контейнера необходимо деплоить в Kubernetes кластер.
6. Деплой должен происходить с использованием сервисного аккаунта.
7. Деплой так же должен происходить с использованием helm.
8. Используйте helm-secrets для шифрования секретов
9. Приложение должно:
10. деплоится в namespace test
11. деплоймент должен называться application
12. сервис для доступа к приложению должен называться app-svc
13. образ контейнера для приложения должен запрашиваться с registry.rebrainme.com
14. После выполнения задания при формировании ответа добавьте вывод команд kubectl, который сможет подтвердить создание всех необходимых по заданию объектов kubernetes в назначенном по заданию namespace.


```
## репа 
https://gitlab.rebrainme.com/kubernetes_users_repos/1332/kub-35.git

## Установка sops
wget https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux
mv sops-v3.7.1.linux /usr/local/bin/sops
chmod +x /usr/local/bin/sops
sops -v

## сгенерируем приватный pgp ключ (указали только свое имя и email адрес)
gpg --gen-key

## clone repo
https://gitlab.rebrainme.com/kubernetes_users_repos/1332/kub-35.git

## Шифруем secrets.test.yaml
sops -e --encrypted-suffix private_env_varibles --pgp ... secrets.yaml > secrets.test.yaml

## Установите nginx-ingress контроллер в namespace ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
kubectl -n ingress-nginx get svc

kubectl create namespace test

## Создать переменную в settings -> CI/CD -> varibles KUBECONFIG и HELM_SECRET
## Для получения KUBECONFIG
cat .kube/config
## Для получения HELM_SECRET
gpg --armor --export-secret-key <key pgp>

## Создать токен settings -> Access Tokens имя любое. 

## Создаём данные для аунтификации на gitlab (чтобы кубер мог скачать образ)
kubectl -n test create secret docker-registry gitlab-secret --docker-username=welcome-news_at_mail_ru --docker-password=glp... --docker-server=registry.rebrainme.com
или
## Нужно!
sudo chmod 666 /var/run/docker.sock
docker login https://gitlab.rebrainme.com/kubernetes_users_repos/1332/kub-35/
kubectl -n test create secret generic gitlab-secret --from-file=.dockerconfigjson=/home/user/.docker/config.json --type=kubernetes.io/dockerconfigjson


## Редактируем сервисный аккаунт дефолт
kubectl -n test edit sa default
## добавляем
imagePullSecrets:
- name: gitlab-secret

kubectl -n test get sa default -o yaml

##
kubectl -n test run alpine --image alpine -- ping 8.8.8.8
kubectl -n test exec -it alpine -- sh
apk add curl
curl -D - app-svc

```

https://github.com/traefik/whoami

https://docs.gitlab.com/ee/ci/variables/predefined_variables.html

https://helm.sh/ru/docs/intro/using_helm/


