output "team_id" {
  description = "ID of the created team"
  value       = module.team.id
}

output "api_integration_id" {
  description = "ID of the API integration"
  value       = module.api_integration.id
}

output "api_integration_key" {
  description = "API key for the integration (sensitive)"
  value       = module.api_integration.api_key
  sensitive   = true
}

output "email_integration_id" {
  description = "ID of the email integration"
  value       = module.email_integration.id
}

output "integration_action_id" {
  description = "ID of the integration action"
  value       = module.api_integration_action.id
}

output "critical_alert_policy_id" {
  description = "ID of the critical alert policy"
  value       = module.critical_alert_policy.id
}

output "warning_alert_policy_id" {
  description = "ID of the warning alert policy"
  value       = module.warning_alert_policy.id
}

output "notification_policy_id" {
  description = "ID of the notification policy"
  value       = module.notification_policy.id
}
