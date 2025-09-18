output "id" {
  description = "Email integration ID"
  value       = try(atlassian-operations_email_integration.this[0].id, null)
}
