# Mezmo Pulse

> Helm chart for managing a Mezmo Pulse deployment

## Prerequisites

- Kubernetes 1.10+ (1.23+ if using autoscaling)
- Mezmo Account with Pulse Pipeline support
- Mezmo API Token


## Quickstart

```sh
helm install pulse . \
  --namespace <MY_NAMESPACE> \
  --set mezmoApiAccessToken=<MEZMO_API_ACCESS_TOKEN> \
  --set service.sourcePorts.start=<START_PORT> \
  --set service.sourcePorts.end=<END_PORT> \
```

## Configuration

### Values

| **Key**                   | **Type** | **Default**     | **Description**                                                        |
| ------------------------- | -------- | --------------- | ---------------------------------------------------------------------- |
| mezmoApiScheme            | string   | "https"         | The scheme to use for the Mezmo API URL                                |
| mezmoApiHost              | string   | "api.mezmo.com" | The hostname(:port) of the Mezmo API                                   |
| mezmoApiAccessToken       | string   |                 | Your Mezmo API access token                                            |
| logLevel                  | string   | info            | Controls the logging verbosity of the deployment                       |
| autoscaling.enabled       | boolean  | false           | Whether or not to enable a HorizontalPodAutoscaler for this deployment |
| service.sourcePorts       | object   |                 | A port range to allocate to sources within the Kubernetes service      |
| service.sourcePorts.start | int      |                 | The start of the port range                                            |
| service.sourcePorts.end   | int      |                 | The end of the port range                                              |
