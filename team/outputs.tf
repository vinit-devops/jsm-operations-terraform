output "team_id" {
  value       = try(atlassian-operations_team.this[0].id, null)
  description = "The ID of the created JSM team"
}

output "team_display_name" {
  value       = try(atlassian-operations_team.this[0].display_name, null)
  description = "The display name of the created JSM team"
}
