variable "enabled" {
  description = "Enable this resource"
  type        = bool
  default     = true
}

variable "alert_policy" {
  description = "Configuration for the alert policy"
  type = object({
    name        = string
    description = optional(string)
    team_id     = optional(string)
    type        = optional(string)
    enabled     = optional(bool)
    message     = optional(string)

    filter = optional(object({
      type       = string
      conditions = list(object({
        field          = string
        not            = optional(bool)
        operation      = string
        expected_value = string
        order          = optional(number)
      }))
    }))

    actions = optional(list(string))
    tags    = optional(list(string))
    details = optional(map(string))

    continue                   = optional(bool)
    update_priority            = optional(bool)
    priority_value             = optional(string)
    keep_original_responders   = optional(bool)
    keep_original_details      = optional(bool)
    keep_original_actions      = optional(bool)
    keep_original_tags         = optional(bool)
  })
}

