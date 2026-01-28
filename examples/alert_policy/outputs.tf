output "alert_policy_id" {
  description = "ID of the created alert policy"
  value       = module.alert_policy.id
}

output "alert_policy_name" {
  description = "Name of the alert policy"
  value       = module.alert_policy.name
}
