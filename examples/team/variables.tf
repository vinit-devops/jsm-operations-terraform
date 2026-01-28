variable "jsm_ops_api_key" {
  description = "JSM Operations API Key"
  type        = string
  sensitive   = true
}

variable "organization_id" {
  description = "Atlassian Organization ID"
  type        = string
}

variable "member_account_id_1" {
  description = "First team member account ID"
  type        = string
}

variable "member_account_id_2" {
  description = "Second team member account ID"
  type        = string
}
