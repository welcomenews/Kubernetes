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
sops -e private_env_varibles --pgp .... secrets.test.yaml

kubectl create namespace test




```
