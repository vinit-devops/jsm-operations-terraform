resource "atlassian-operations_integration_action" "this" {
  integration_id = var.integration_id
  name           = var.name
  type           = var.type
  domain         = var.domain
  direction      = var.direction
  filter = var.filter
  type_specific_properties = jsonencode(var.type_specific_properties)
  field_mappings           = jsonencode(var.field_mappings)
}
