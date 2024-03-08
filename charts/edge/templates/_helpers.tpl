{{/*
Expand the name of the chart.
*/}}
{{- define "edge.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "edge.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "edge.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "edge.labels" -}}
helm.sh/chart: {{ include "edge.chart" . }}
{{ include "edge.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "edge.selectorLabels" -}}
app.kubernetes.io/name: {{ include "edge.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "edge.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "edge.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate the base URL of the Mezmo API
*/}}
{{- define "edge.mezmoApiBaseUrl" -}}
{{- printf "%s://%s" .Values.mezmoApiScheme .Values.mezmoApiHost }}
{{- end }}

{{/*
Ports as a yaml array
*/}}
{{- define "edge.sourcePorts" -}}
{{- $ports := .Values.service.sourcePorts.list }}
{{- $start := .Values.service.sourcePorts.start | default 0 | int }}
{{- $end := .Values.service.sourcePorts.end | default 0 | int }}
{{- range $port := untilStep $start (add1 $end | int) 1 }}
  {{- $ports = append $ports $port }}
{{- end }}
{{- $ports | uniq | toYaml}}
{{- end }}

{{/*
Defaulting Edge ID
*/}}
{{- define "edge.Id" -}}
{{- $id_hash := sha1sum (print .Release.Name .Release.Namespace .Values.mezmoDeploymentGroup) | substr 0 8 }}
{{- (default $id_hash .Values.edgeIdOverride) }}
{{- end }}

{{/*
Base attributes for heartbeat
*/}}
{{- define "edge.heartbeatCommon" -}}
edge_id: {{ include "edge.Id" . | quote }}
namespace: {{ $.Release.Namespace }}
name: {{ $.Release.Name }}
{{- if .Values.mezmoDeploymentGroup }}
deployment_group: {{ .Values.mezmoDeploymentGroup | quote }}
{{- end }}
ports: {{- include "edge.sourcePorts" . | nindent 2 }}
version: edge-{{ $.Chart.Version }}
{{- end }}

{{/*
Secret file name to use
*/}}
{{- define "edge.tokenSecretRef" -}}
{{- if .Values.mezmoApiAccessSecret }}
name: {{ .Values.mezmoApiAccessSecret }}
{{- else }}
{{- if .Values.mezmoApiAccessToken }}
name: {{ include "edge.fullname" . }}
{{- else }}
{{ fail .Values.tokenSecretRefError }}
{{- end }}
{{- end }}
{{- end }}
