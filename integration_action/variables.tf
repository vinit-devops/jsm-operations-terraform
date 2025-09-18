variable "integration_id" {
  description = "Integration ID for the email integration"
  type        = string
}

variable "name" {
  description = "Integration action name."
  type        = string
}

variable "type" {
  description = "Action type (e.g., 'create')."
  type        = string
}

variable "domain" {
  description = "Action domain (e.g., 'alert')."
  type        = string
}

variable "direction" {
  description = "Action direction (e.g., 'incoming')."
  type        = string
}

variable "filter" {
  description = "Filter object with list-of-conditions."
  type = object({
    condition_match_type = string
    conditions_empty     = bool
    conditions = list(object({
      field            = string
      operation        = string
      expected_value   = string
      not              = bool
      order            = number
      system_condition = bool
    }))
  })
}

variable "type_specific_properties" {
  description = "HCL object encoded to JSON for type_specific_properties."
  type        = any
  default     = {}
}

variable "field_mappings" {
  description = "HCL object encoded to JSON for field_mappings."
  type        = any
  default     = {}
}