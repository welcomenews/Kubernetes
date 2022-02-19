## KUB 10: Kubernetes API

1. Создайте pod с образом nginx и именем nginx-pod в namespace default.
2. Используя curl, добавьте поду label api=true.

```
mkdir tmp
# Декодируем CA сертификат
$ echo 'LS0...' | base64 -d > tmp/ca.crt
# Декодируем клиентский сертификат
$ echo 'LS0...' | base64 -d > tmp/client.crt
# Декодируем клиентский ключ
$ echo 'LS0...' | base64 -d > tmp/client.key

export APISERVER=$(kubectl config view -o jsonpath='{.clusters[0].cluster.server}')
export POD_NAMESPACE=default
export POD_NAME=nginx-pod

cat > patch.json <<EOF
[ 
 { 
 "op": "add", "path": "/metadata/labels/api", "value": "true" 
 } 
]
EOF

curl -D - -s --request PATCH --data "$(cat patch.json)" --cacert tmp/ca.crt --cert tmp/client.crt --key tmp/client.key -H "Content-Type:application/json-patch+json" $APISERVER/api/v1/namespaces/$POD_NAMESPACE/pods/$POD_NAME

```


https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.23/#read-pod-v1-core

https://kubernetes.io/docs/concepts/overview/kubernetes-api/

https://stackoverflow.com/questions/37481205/how-to-delete-a-label-for-a-kubernetes-pod

https://stackoverflow.com/questions/47837008/kubernetes-api-how-to-add-remove-label-from-node

https://stackoverflow.com/questions/36147137/kubernetes-api-add-label-to-pod

