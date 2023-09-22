# Mezmo Helm Charts

Helm charts for Mezmo products.

## How to use the Helm repository

You need to add this repository to your Helm repositories:

```shell
helm repo add mezmo https://mezmo.github.io/helm-charts/
helm repo update
```

### Installing Mezmo Pulse

```shell
helm install my_pulse_deployment mezmo/pulse \
--set mezmoApiAccessToken=<PIPELINE_SERVICE_TOKEN> \
--set service.sourcePorts.start=8080 \
--set service.sourcePorts.end=8100
```
