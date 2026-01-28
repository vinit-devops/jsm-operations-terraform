variable "jsm_ops_api_key" {
  description = "JSM Operations API Key"
  type        = string
  sensitive   = true
}

variable "integration_id" {
  description = "ID of the integration this action belongs to"
  type        = string
}
