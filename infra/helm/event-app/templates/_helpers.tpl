{{- define "event-app.name" -}}
event-app
{{- end -}}

{{- define "event-app.fullname" -}}
{{ printf "%s" (include "event-app.name" .) }}
{{- end -}}
