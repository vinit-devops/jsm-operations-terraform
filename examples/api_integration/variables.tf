variable "jsm_ops_api_key" {
  description = "JSM Operations API Key"
  type        = string
  sensitive   = true
}

variable "team_id" {
  description = "Optional team ID for the integration"
  type        = string
  default     = null
}
