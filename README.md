# Mezmo Helm Charts

Helm charts for Mezmo products.

## How to install the Helm repository

You need to add this repository to your Helm repositories:

```shell
helm repo add mezmo https://helm.mezmo.com
helm repo update

# Use the default port range, 8000-8010
helm install edge mezmo/edge \
  --set mezmoApiAccessToken=<MEZMO_API_ACCESS_TOKEN>
```

## Upgrading

When a new version is available, update the helm charts and upgrade the instance.

```shell
helm repo update mezmo
helm upgrade --reuse-values edge mezmo/edge
```

See the [chart README](charts/edge/README.md) for more usage details.
