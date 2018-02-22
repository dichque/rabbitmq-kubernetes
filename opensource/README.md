Proof of Concept: RabbitMQ persistant cluster on Kubernetes
----
[Jagadish Nagarajaiah](jaganaga@cisco.com) <br>
Date: 7th Feb 2018

## Objective
* Build scalable, secure & persistant RabbitMQ messaging cluster

## Features leveraged
* Kubernetes statefulsets
* RabbitMQ peer discovery plugin

## Testbed
* Kubernetes 1.9.0
* Openshift 3.6

```
minikube version: v0.25.0
```

```
kubectl version
Client Version: version.Info{Major:"1", Minor:"9", GitVersion:"v1.9.0", GitCommit:"925c127ec6b946659ad0fd596fa959be43f0cc05", GitTreeState:"clean", BuildDate:"2017-12-16T03:15:38Z", GoVersion:"go1.9.2", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"", Minor:"", GitVersion:"v1.9.0", GitCommit:"925c127ec6b946659ad0fd596fa959be43f0cc05", GitTreeState:"clean", BuildDate:"2018-01-26T19:04:38Z", GoVersion:"go1.9.1", Compiler:"gc", Platform:"linux/amd64"}
```

* Docker

```
20:46 $ docker version
Client:
 Version:       17.12.0-ce
 API version:   1.23
 Go version:    go1.9.2
 Git commit:    c97c6d6
 Built: Wed Dec 27 20:03:51 2017
 OS/Arch:       darwin/amd64

Server:
 Engine:
  Version:      17.09.0-ce
  API version:  1.32 (minimum version 1.12)
  Go version:   go1.8.3
  Git commit:   afdb6d4
  Built:        Tue Sep 26 22:45:38 2017
  OS/Arch:      linux/amd64
  Experimental: false
```

## Demo

* Create namespace

```
kubectl create namespace rabbitmq-poc
```

* Switch namespace

```
$ kubectl config set-context $(kubectl config current-context) --namespace=rabbitmq-poc
$ kubectl config view | grep namespace:
```

* Create objects

```
kubectl create -f rbac.yaml
kubectl create -f stsets.yaml
```

* Persistant Volme

```
kubectl get pvc
```

* Pod status

```
kubectl get pods
kubectl exec rabbitmq-0 rabbitmqctl cluster_status
```

* Publish Messages
FIXME

* Pod failure and recovery

```
kubectl get pods
kubectl delete pods --all
```

* Pod rolling upgrade

```
kubectl patch statefulset rabbitmq -p '{"spec":{"updateStrategy":{"type":"RollingUpdate"}}}'

kubectl patch statefulset rabbitmq --type='json'  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"rabbitmq:3.7-alpine"}]'

kubectl patch statefulset rabbitmq --type='json'  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"rabbitmq:3.7"}]'

kubectl exec -it rabbitmq-0 -- /bin/bash
```

* Scaling

```
$ kubectl scale statefulset/rabbitmq --replicas=3
```

* Monitoring
  - Pod health monitored by Kubernetes via user defined health check probes
  - Service can be monitored via RabbitMQ API
  - Support for TIGK stack (if required) need to be built in.

## Gotchas
* DNS resolution of pods
* Openshift specific
  - Service and routes
  - PVC
  - Limited Ingress IP


## Next steps
* Enable SSL
* Test with sample client
* Rolling it out on CAE
* Performance testing
* Monitoring


## Recording link
FIXME

## Reference
* [https://kubernetes.io/docs/concepts/workloads/controllers/statefulset](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset)
* [https://www.rabbitmq.com/clustering.html](https://www.rabbitmq.com/clustering.html)
