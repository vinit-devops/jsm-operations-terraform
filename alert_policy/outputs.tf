output "id" {
  value       = try(atlassian-operations_alert_policy.this[0].id, null)
  description = "ID of the created JSM Operations alert policy"
}

output "name" {
  value       = try(atlassian-operations_alert_policy.this[0].name, null)
  description = "Name of the alert policy"
}
