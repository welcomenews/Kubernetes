## KUB 26: Role Based Access Control в Kubernetes

1. Создайте сервисный аккаунт sa-dp в namespace default.
2. Создайте кластерную роль cr-dp, которая будет позволять создавать deployments.
3. Привяжите аккаунт sa-dp к роли cr-dp в namespace default, используя rolebinding sa-dp-cr-dp.

```
kubectl apply -f ./sa_def.yaml
kubectl apply -f ./cluster_role_def.yaml
kubectl apply -f ./rolebind_def.yaml

kubectl get sa
kubectl get ClusterRole
kubectl get RoleBinding

```

https://kubernetes.io/docs/concepts/security/controlling-access/

https://kubernetes.io/docs/reference/access-authn-authz/authorization/

https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/

https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/

https://kubernetes.io/docs/reference/access-authn-authz/authentication/

https://kubernetes.io/docs/reference/access-authn-authz/rbac/

https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/

https://itnext.io/securing-the-configuration-of-kubernetes-cluster-components-c9004a1a32b3

