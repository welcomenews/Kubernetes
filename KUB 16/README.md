## KUB 16: Запуск подов на определенных узлах


1. Добавьте всем нодам в кластере label usercase=workload.
2. Добавьте на одну ноду taint dedicated=true noSchedule.
3. Создайте deployment dp-label, который будет запускать поды на нодах с label usercase=workload, и укажите количество реплик — 5 штук.
4. Создайте deployment dp-taint, который будет запускать поды на нодах с label usercase=workload, и toleration, который удовлетворяет условию dedicated=true.

```
kubectl label nodes --all usercase=workload
## если у пода нет такого параметра, то его не размещаем на этой ноде.
kubectl taint nodes node1 dedicated=true:NoSchedule

kubectl apply -f ./deploy-label.yaml
kubectl apply -f ./deploy-taint.yaml

kubectl describe node node2
kubectl get po -o wide
kubectl get deployment -o wide

```

https://vocon-it.com/2019/09/20/cka-14-kubernetes-affinity-and-anti-affinity/

https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/

https://medium.com/@betz.mark/herding-pods-taints-tolerations-and-affinity-in-kubernetes-2279cef1f982

https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/

https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-constraint-namespace/

