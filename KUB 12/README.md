## KUB 12: Базовые ресурсы в Kubernetes - часть 2

1. Добавьте двум узлам вашего кластера метки usecase=loadbalancer.
2. Создайте daemonset с именем nginx-ds в namespace default, который будет запускать nginx на всех узлах с метками usecase=loadbalancer.
3. Создайте CronJob с именем cron-test в namespace default, который будет раз в 10 минут (*/10 * * * *) запускать alpine с командой curl https://lk.rebrainme.com/kubernetes/report.

```
kubectl label nodes node2 usecase=loadbalancer
kubectl label nodes node3 usecase=loadbalancer

kubectl apply -f ./daemonset.yaml
kubectl apply -f ./cronjob.yaml

kubectl get po -o wide
kubectl get cronjob -o wide
kubectl get all --all-namespaces
kubectl get ds --all-namespaces

```

https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/

https://www.golinuxcloud.com/kubectl-label-node/

https://medium.com/google-cloud/kubernetes-running-background-tasks-with-batch-jobs-56482fbc853

https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/

https://kubernetes.io/docs/tasks/manage-daemon/update-daemon-set/

https://cloud.google.com/kubernetes-engine/docs/concepts/daemonset

