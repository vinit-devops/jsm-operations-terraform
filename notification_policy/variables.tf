variable "enabled" {
  description = "Whether to create this notification policy"
  type        = bool
  default     = true
}

variable "notification_policy" {
  description = "Configuration for a single JSM Operations notification policy"
  type = object({
    name        = string
    description = optional(string)
    enabled     = optional(bool, true)
    team_id     = string
    filter = object({
      type       = optional(string, "match-all")
      conditions = list(object({
        field          = string
        operation      = string
        expected_value = string
        not            = optional(bool, false)
        order          = optional(number)
      }))
    })
    auto_close_action = object({
      wait_duration   = number
      duration_format = string
    })
  })

  validation {
    condition     = length(var.notification_policy.name) >= 1 && length(var.notification_policy.name) <= 250
    error_message = "notification_policy.name must be between 1 and 250 characters."
  }
}