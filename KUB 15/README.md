## KUB 15: Планирование запуска pods

1. Создайте deployment cache-dp с двумя контейнерами memcached, redis.
2. Установите requests / limits таким образом, чтобы QoS для этих подов был Guaranteed.
3. Ограничьте использование ресурсов в namespace default максимально 4 ядрами CPU и 16 Gib памяти.


```
kubectl apply -f deploy.yaml
kubectl apply -f rq.yaml

kubectl get po
kubectl get deployment -o=wide
kubectl get ResourceQuota
kubectl describe node

```



https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-constraint-namespace/

https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/memory-constraint-namespace/

https://kubernetes.io/docs/concepts/policy/limit-range/

https://kubernetes.io/docs/concepts/policy/resource-quotas/

https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

https://kubernetes.io/docs/concepts/policy/resource-quotas/

https://goteleport.com/blog/kubernetes-resource-planning/

https://habr.com/ru/company/flant/blog/575656/

