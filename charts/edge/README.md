# Mezmo Edge

> Helm chart for managing a Mezmo Edge deployment

## Prerequisites

- Kubernetes 1.10+ (1.23+ if using autoscaling)
- Mezmo Account with Edge Pipeline support
- Mezmo API Token


## Quickstart

```sh
helm install edge mezmo/edge \
  --namespace <MY_NAMESPACE> \
  --set mezmoApiAccessToken=<MEZMO_API_ACCESS_TOKEN>
```

By default ports in the range [8000, 8010] are configured. See `service.sourcePorts.*` values for configuring different ranges. For example, to configure with no contiguous range and two ports (syslog and http) exposed:

```sh
helm install edge mezmo/edge \
  --set mezmoApiAccessToken=<MEZMO_API_ACCESS_TOKEN> \
  --set service.sourcePorts.end=0 \
  --set service.sourcePorts.list="{514,80}"
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
| service.sourcePorts       | object   |                 | A port range to allocate to sources within the Kubernetes service*     |
| service.sourcePorts.start | int      | 8000            | The start of the port range (inclusive [start, end])                   |
| service.sourcePorts.end   | int      | 8010            | The end of the port range (set 0 or "" to disable port range)          |
| service.sourcePorts.list  | array[]  | []              | Optional list of discrete ports to configure on the service            |

\* Port 8686 is reserved for internal use, and should not be additionally configured for sourcePorts
