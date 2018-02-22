
## Deploying RabbitMQ on Openshift 3.6
---

## Steps to create openshift objects

```
oc create -f rbac.yaml

oc adm policy add-role-to-user endpoint-reader system:serviceaccount:gpm-poc:rabbitmq --role-namespace=gpm-poc

oc create -f config.yaml

oc create -f stsets.yaml

oc create -f service.yaml
```

## RabbitMQ management console

[https://rabbitmq-mgmt-gpm-poc.cisco.com/#/queues](https://rabbitmq-mgmt-gpm-poc.cisco.com/#/queues)


## Openshift functionalities

* Statefulset
* Persistent volumes
* Ingress IP
* Routes and Services
* Configmap

## Issues

* Routes not being accessible.
* Volume not being allocated during deployment and scaling
* PingID authentication failures, authentication keeps shifting from SSO test and SSO nprod portal.
* Quota restriction errors while spawning pods even when there is sufficient free resources are available.
* Ingress IP not accessible after recreating the service. This issue is reproducible and by deleting and recreating the service.
