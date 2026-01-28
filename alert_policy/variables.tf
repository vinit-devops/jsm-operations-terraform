variable "enabled" {
  description = "Whether to create this alert policy"
  type        = bool
  default     = true
}

variable "alert_policy" {
  description = "Configuration for a single JSM Operations alert policy"
  type = object({
    name        = string
    description = optional(string)
    team_id     = optional(string)
    type        = optional(string, "alert")
    enabled     = optional(bool, true)
    message     = optional(string, "{{message}}")

    filter = optional(object({
      type       = optional(string, "match-all")
      conditions = optional(list(object({
        field          = string
        not            = optional(bool, false)
        operation      = string
        expected_value = string
        order          = optional(number)
      })), [])
    }), {
      type       = "match-all"
      conditions = []
    })

    actions = optional(list(string), [])
    tags    = optional(list(string), [])
    details = optional(map(string), {})

    continue                   = optional(bool, false)
    update_priority            = optional(bool, false)
    priority_value             = optional(string)
    keep_original_responders   = optional(bool, false)
    keep_original_details      = optional(bool, false)
    keep_original_actions      = optional(bool, false)
    keep_original_tags         = optional(bool, false)
  })

  validation {
    condition     = length(var.alert_policy.name) >= 1 && length(var.alert_policy.name) <= 250
    error_message = "alert_policy.name must be between 1 and 250 characters."
  }
}

