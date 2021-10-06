{{/*
Expand the name of the chart.
*/}}
{{- define "ec2-demo-static.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ec2-demo-static.fullname" -}}
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
{{- define "ec2-demo-static.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ec2-demo-static.labels" -}}
helm.sh/chart: {{ include "ec2-demo-static.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Format tags for an instance.
Example:
tags: {{ include "ec2-demo-static.tags" .Values.nodepoolWorker.tags }}
*/}}
{{- define "ec2-demo-static.tags" -}}
{{- $tagStr := "null" }}
{{- range $k, $v := . }}
{{- if (eq $tagStr "null") }}
{{- $tagStr = join "," (list $k $v) }}
{{- else }}
{{- $tagStr = join "," (list $tagStr $k $v) }}
{{- end }}
{{- end }}
{{- if (eq $tagStr "null") -}}
null
{{- else }}
{{- $tagStr | quote }}
{{- end }}
{{- end }}
