## KUB 31: Плагины в Helm на примере плагина шифрования данных

1. Склонируйте репозиторий https://gitlab.rebrainme.com/kubernetes-local-for-tasks/helm-secrets.
2. Создайте ветку secrets.
3. Сгенерируйте собственный gpg-ключ.
4. Внутри папки .infra, создайте файл secrets.prod.yaml, который будет содержать список private_env_variables, внутри которого будут указаны переменные (переменные надо взять из values.prod.yaml):
API_KEY
PGSQL_URI
5. Удалите переменные API_KEY / PGSQL_URI из values.prod.yaml.
6. В итоге у вас должно получиться два файла - values.prod.yaml, который содержит public_env_variables (LISTEN) и secrets.prod yaml, который содержит private_env_variables (API_KEY / PGSQL_URI).
7. Зашифруйте secrets.prod.yaml с помощью sops и ключа, сгенерированного в пункте 3.
8. Создайте репозиторий в группе kubernetes_users_repos/your_gitlab_id/ и запушьте ваши изменения в него.


```
## Установка sops
wget https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux
mv sops-v3.7.1.linux /usr/local/bin/sops
chmod +x /usr/local/bin/sops
sops -v

## сгенерируем приватный pgp ключ (указали только свое имя и email адрес)
gpg --gen-key

## Шифруем secrets.prod.yaml
sops -e --pgp 5D4BB6EAFF2191FFEFEAF986363A0132244119A5 secrets.prod.yaml > tmp
rm secrets.prod.yaml
mv tmp secrets.prod.yaml

sops -d secrets.prod.yaml
git push https://gitlab.rebrainme.com/kubernetes_users_repos/1332/kub-31.git


```

https://helm.sh/docs/topics/plugins/

https://helm.sh/docs/community/related/#helm-plugins



