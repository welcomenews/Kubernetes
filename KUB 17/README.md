##  KUB 17: Ресурсы для хранения конфигурации

1. Создайте configmap nginx-conf в namespace default, содержащую конфигурацию для nginx — nginx.conf, в которой указано количество воркеров — 4 штуки.
2. Создайте secret nginx-env в namespace default с переменной AUTH=testpassword.
3. Создайте под nginx в namespace default, который будет монтировать конфигурацию из configmap и добавлять env переменную из secret.

```





```
