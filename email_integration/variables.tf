variable "enabled" {
  description = "Toggle creation"
  type        = bool
  default     = true
}

variable "email_username" {
  description = "Email username for this integration (e.g. 'cloud-fortified-alerts')"
  type        = string
}

variable "email_integration" {
  description = "Email integration spec (JSM Ops)"
  type = object({
    name                    = string
    enabled                 = bool
    suppress_notifications  = bool
    team_id                 = optional(string)
    integration_id          = optional(string)       
  })
}
