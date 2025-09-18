variable "enabled" {
  description = "Whether to create this API integration"
  type        = bool
  default     = true
}

variable "api_integration" {
  description = "Configuration for a single JSM Ops API integration"
  type = object({
    # Required
    name = string
    type = string

    # Optional
    enabled                = optional(bool)
    delete_default_actions = optional(bool)
    team_id                = optional(string)

    # Accept a structured map/object; we jsonencode it in the resource
    type_specific_properties = optional(any)
  })

  # Helpful validations
  validation {
    condition     = length(var.api_integration.name) >= 1 && length(var.api_integration.name) <= 250
    error_message = "api_integration.name must be between 1 and 250 characters."
  }
}
