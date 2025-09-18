output "jsm_ops_alert_policy_id" {
  value       = try(atlassian-operations_alert_policy.this[0].id, null)
  description = "ID of the created JSM Ops alert policy"
}

