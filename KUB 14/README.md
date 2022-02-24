##KUB 14: Параметры манифестов

Создайте деплоймент с именем nginx-mf в namespace default со следующими правилами:
Образ должен быть nginx:latest
Добавьте label env=prod.
Добавьте аннотацию prometheus.io/scrape=true.
Добавьте liveness probe http на порт 80 с произвольными значениями period & delay.
Добавьте readiness probe command с вызовом curl http://127.0.0.1:80.


```
```



https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/

https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/

https://cloud.google.com/kubernetes-engine/docs/tutorials/http-balancer#step_5_optional_configuring_a_static_ip_address

https://stackoverflow.com/questions/58932210/kubernetes-how-to-pass-pipe-character-in-readiness-probe-command

