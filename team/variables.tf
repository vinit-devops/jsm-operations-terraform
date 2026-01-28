variable "enabled" {
  description = "Whether to create this JSM Operations team"
  type        = bool
  default     = true
}

variable "organization_id" {
  description = "ID of the Atlassian organization"
  type        = string
}

variable "team" {
  description = "Configuration for a single JSM Operations team"
  type = object({
    display_name = string
    description  = optional(string)
    team_type    = optional(string, "MEMBER_INVITE")
    members      = optional(list(object({
      id = string
    })), [])
  })

  validation {
    condition     = length(var.team.display_name) >= 1 && length(var.team.display_name) <= 250
    error_message = "team.display_name must be between 1 and 250 characters."
  }
}

