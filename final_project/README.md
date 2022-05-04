## 

1. Установите в kubernetes кластер базу данных mysql.
2. Установите в kubernetes кластер cert-manager & nginx-ingress-controller.
3. Установите в kubernetes кластер Prometheus стек для мониторинга состояния кластера (должен быть доступен по https)
4. Установите в kubernetes кластер EFK стек для сбора логов с контейнеров (должен быть доступен по https)
5. Напишите хельм чарт для wordpress блога - который будет:
* использовать образ https://hub.docker.com/_/wordpress
* создавать deployment для wordpress с количеством реплик 1
* подключать директорию uploads с внешнего nfs сервера (будет вам выдан)
* шифровать секретные env-переменные для подключения к базе данных
* создавать ingress для доступа к wordpress
6. Создайте репозиторий в https://gitlab.rebrainme.com/kubernetes_users_repos/<your_gitlab_id>/ и разместите там:
* gitlab-ci.yml - настройки для деплоя вашего хельм чарта в dev / prod окружения
* helm чарт для wordpress приложения
7. в директории internal разместить все манифесты (или чарты), которые вы использовали для запуска mysql базы и nfs provisioner'а

```
1.
## Секрет для mysql
kubectl apply -f mysql-secret.yaml

kubectl apply -f mysql-deployment.yaml

2.
## Установка nginx-ingress контроллера
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml

## Делаем DNS запись
curl -X POST "https://api.cloudflare.com/client/v4/zones/9152ec3c08b1a4faeaa95353a929fcc5/dns_records" -H "Authorization: Bearer dfg..." -H "Content-Type:application/json" --data '{"type":"A","name":"ingress.d6315.task22.rbr-kubernetes.com","content":"157.245.18.47","proxied":false}'

## cert-manager
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.1.0/cert-manager.yaml
## необходимо создать новый clusterIssuer, который будет выписывать сертификаты через letsencrypt
kubectl apply -f ./sert_manager_nginx.yaml


kubectl apply -f ./prometheus.yaml

```
