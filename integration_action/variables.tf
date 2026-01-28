variable "enabled" {
  description = "Whether to create this integration action"
  type        = bool
  default     = true
}

variable "integration_id" {
  description = "ID of the integration this action belongs to"
  type        = string
}

variable "name" {
  description = "Name of the integration action"
  type        = string

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 250
    error_message = "name must be between 1 and 250 characters."
  }
}

variable "type" {
  description = "Type of the integration action (e.g., 'create', 'update')"
  type        = string
}

variable "domain" {
  description = "Domain of the integration action (e.g., 'alert', 'incident')"
  type        = string
}

variable "direction" {
  description = "Direction of the integration action (e.g., 'incoming', 'outgoing')"
  type        = string
}

variable "filter" {
  description = "Filter configuration for the integration action"
  type = object({
    condition_match_type = optional(string, "match-all")
    conditions_empty     = optional(bool, false)
    conditions = list(object({
      field            = string
      operation        = string
      expected_value   = string
      not              = optional(bool, false)
      order            = optional(number)
      system_condition = optional(bool, false)
    }))
  })
}

variable "type_specific_properties" {
  description = "Type-specific properties for the integration action (will be JSON encoded)"
  type        = any
  default     = {}
}

variable "field_mappings" {
  description = "Field mappings for the integration action (will be JSON encoded)"
  type        = any
  default     = {}
}