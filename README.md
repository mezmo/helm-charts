# Mezmo Helm Charts

Helm charts for Mezmo products.

## How to use the Helm repository

You need to add this repository to your Helm repositories:

```shell
helm repo add mezmo https://helm.mezmo.com
helm repo update
```

### Installing Mezmo Edge

```shell
helm install edge mezmo/edge \
  --namespace <MY_NAMESPACE> \
  --set mezmoApiAccessToken=<MY_PIPELINE_SERVICE_TOKEN> \
```
