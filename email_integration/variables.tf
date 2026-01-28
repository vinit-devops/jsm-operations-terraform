variable "enabled" {
  description = "Whether to create this email integration"
  type        = bool
  default     = true
}

variable "email_integration" {
  description = "Configuration for a single JSM Operations email integration"
  type = object({
    name                   = string
    email_username         = string
    enabled                = optional(bool, true)
    suppress_notifications = optional(bool, false)
    team_id                = optional(string)
  })

  validation {
    condition     = length(var.email_integration.name) >= 1 && length(var.email_integration.name) <= 250
    error_message = "email_integration.name must be between 1 and 250 characters."
  }
}
