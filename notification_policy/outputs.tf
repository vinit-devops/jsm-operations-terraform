output "id" {
  value       = try(atlassian-operations_notification_policy.this[0].id, null)
  description = "ID of the created JSM Operations notification policy"
}

output "name" {
  value       = try(atlassian-operations_notification_policy.this[0].name, null)
  description = "Name of the notification policy"
}
