output "id" {
  value       = try(atlassian-operations_team.this[0].id, null)
  description = "ID of the created JSM Operations team"
}

output "name" {
  value       = try(atlassian-operations_team.this[0].display_name, null)
  description = "Display name of the team"
}

output "display_name" {
  value       = try(atlassian-operations_team.this[0].display_name, null)
  description = "Display name of the team (alias for name)"
}
