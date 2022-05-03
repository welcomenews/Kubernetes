## KUB 35: Настройка CI/CD в Gitlab для Kubernetes




```
## Установка sops
wget https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux
mv sops-v3.7.1.linux /usr/local/bin/sops
chmod +x /usr/local/bin/sops
sops -v

## сгенерируем приватный pgp ключ (указали только свое имя и email адрес)
gpg --gen-key

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
kubectl -n test create secret docker-registry gitlab-secret --docker-username=welcome-news_at_mail_ru --docker-password=glp... --docker-server=registry.gitlab.com
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



```
