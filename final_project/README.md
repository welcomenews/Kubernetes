## 

Установите в kubernetes кластер базу данных mysql.
Установите в kubernetes кластер cert-manager & nginx-ingress-controller.
Установите в kubernetes кластер Prometheus стек для мониторинга состояния кластера (должен быть доступен по https)
Установите в kubernetes кластер EFK стек для сбора логов с контейнеров (должен быть доступен по https)
Напишите хельм чарт для wordpress блога - который будет:
использовать образ https://hub.docker.com/_/wordpress
создавать deployment для wordpress с количеством реплик 1
подключать директорию uploads с внешнего nfs сервера (будет вам выдан)
шифровать секретные env-переменные для подключения к базе данных
создавать ingress для доступа к wordpress
Создайте репозиторий в https://gitlab.rebrainme.com/kubernetes_users_repos/<your_gitlab_id>/ и разместите там:
gitlab-ci.yml - настройки для деплоя вашего хельм чарта в dev / prod окружения
helm чарт для wordpress приложения
в директории internal разместить все манифесты (или чарты), которые вы использовали для запуска mysql базы и nfs provisioner'а

```



```
