variable "jsm_ops_api_key" {
  description = "JSM Operations API Key"
  type        = string
  sensitive   = true
}

variable "team_id" {
  description = "Optional team ID to scope the policy"
  type        = string
  default     = null
}
