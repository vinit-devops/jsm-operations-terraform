resource "atlassian-operations_notification_policy" "this" {
  count = var.enabled ? 1 : 0

  type        = "notification"
  name        = var.notification_policy.name
  enabled     = try(var.notification_policy.enabled, true)
  team_id     = var.notification_policy.team_id
  description = try(var.notification_policy.description, var.notification_policy.name)

  auto_close_action = {
    wait_duration   = var.notification_policy.auto_close_action.wait_duration
    duration_format = var.notification_policy.auto_close_action.duration_format
  }

  filter = {
    type = try(var.notification_policy.filter.type, "match-all")
    conditions = [
      for c in var.notification_policy.filter.conditions : {
        field          = c.field
        operation      = c.operation
        expected_value = c.expected_value
        not            = try(c.not, false)
        order          = try(c.order, null)
      }
    ]
  }

  lifecycle {
    ignore_changes = [team_id]
  }
}