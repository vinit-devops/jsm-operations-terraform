resource "atlassian-operations_api_integration" "this" {
  count = var.enabled ? 1 : 0

  # Required
  name = var.api_integration.name
  type = var.api_integration.type

  # Optional (simple)
  enabled                = try(var.api_integration.enabled, true)
  delete_default_actions = try(var.api_integration.delete_default_actions, false)

  # Optional immutable; only set if provided to avoid provider weirdness
  team_id = try(var.api_integration.team_id, null)

  # Optional: provider expects a JSON string
  # Accept a map/object and jsonencode it here if given
  type_specific_properties = (
    contains(keys(var.api_integration), "type_specific_properties") &&
    var.api_integration.type_specific_properties != null
  ) ? jsonencode(var.api_integration.type_specific_properties) : null

  # Lifecycle guard: team_id is immutable and may be injected; ignore drift
  lifecycle {
    ignore_changes = [team_id]
  }
}

