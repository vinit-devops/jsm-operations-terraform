resource "atlassian-operations_notification_policy" "this" {
  type        = "notification"
  name        = var.notification_policy.name
  enabled     = var.notification_policy.enabled
  team_id     = var.notification_policy.team_id
  description = var.notification_policy.description

  auto_close_action = {
    wait_duration   = var.notification_policy.auto_close_action.wait_duration
    duration_format = var.notification_policy.auto_close_action.duration_format
  }

  filter = {
    type = var.notification_policy.filter.type
    conditions = [
      for c in var.notification_policy.filter.conditions : {
        field          = c.field
        operation      = c.operation
        expected_value = c.expected_value
      }
    ]
  }
}