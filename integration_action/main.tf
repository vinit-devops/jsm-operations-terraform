resource "atlassian-operations_integration_action" "this" {
  count = var.enabled ? 1 : 0

  integration_id = var.integration_id
  name           = var.name
  type           = var.type
  domain         = var.domain
  direction      = var.direction

  filter = {
    condition_match_type = try(var.filter.condition_match_type, "match-all")
    conditions_empty     = try(var.filter.conditions_empty, false)
    conditions = [
      for c in var.filter.conditions : {
        field            = c.field
        operation        = c.operation
        expected_value   = c.expected_value
        not              = try(c.not, false)
        order            = try(c.order, null)
        system_condition = try(c.system_condition, false)
      }
    ]
  }

  type_specific_properties = length(var.type_specific_properties) > 0 ? jsonencode(var.type_specific_properties) : null
  field_mappings           = length(var.field_mappings) > 0 ? jsonencode(var.field_mappings) : null
}
