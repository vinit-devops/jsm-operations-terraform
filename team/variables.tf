variable "enabled" {
  type        = bool
  default     = true
  description = "Whether to create the JSM operations team"
}

variable "organization_id" {
  type        = string
  description = "ID of the Atlassian organization"
}

variable "team" {
  type = object({
    display_name = string
    description  = optional(string)
    members      = list(object({
      id = string
    }))
  })

  description = "JSM team object"
}

