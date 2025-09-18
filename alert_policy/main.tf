resource "atlassian-operations_alert_policy" "this" {
  count     = var.enabled ? 1 : 0

  name        = var.alert_policy.name
  description = try(var.alert_policy.description, var.alert_policy.name)
  type        = try(var.alert_policy.type, "alert")
  enabled     = try(var.alert_policy.enabled, true)
  message     = try(var.alert_policy.message, "{{message}}")

  filter = {
    type = try(var.alert_policy.filter.type, "match-all")
    conditions = try(var.alert_policy.filter.conditions, [])
  }

  time_restriction = {
    enabled = false
    time_restrictions = []
  }

  actions    = try(var.alert_policy.actions, [])
  tags       = try(var.alert_policy.tags, [])
  details    = try(var.alert_policy.details, {})

  continue                   = try(var.alert_policy.continue, false)
  update_priority            = try(var.alert_policy.update_priority, false)
  priority_value             = try(var.alert_policy.priority_value, null)
  keep_original_responders   = try(var.alert_policy.keep_original_responders, false)
  keep_original_details      = try(var.alert_policy.keep_original_details, false)
  keep_original_actions      = try(var.alert_policy.keep_original_actions, false)
  keep_original_tags         = try(var.alert_policy.keep_original_tags, false)
  lifecycle {
    ignore_changes = [team_id]
  }
}
