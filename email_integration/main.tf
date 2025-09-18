resource "atlassian-operations_email_integration" "this" {
  count   = var.enabled ? 1 : 0

  name    = var.email_integration.name
  enabled = try(var.email_integration.enabled, true)
  team_id = try(var.email_integration.team_id, null)
  type_specific_properties = {
    email_username        = var.email_username
    suppress_notifications = try(var.email_integration.suppress_notifications, false)
  }
}