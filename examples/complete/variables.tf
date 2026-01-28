variable "jsm_ops_api_key" {
  description = "JSM Operations API Key"
  type        = string
  sensitive   = true
}

variable "organization_id" {
  description = "Atlassian Organization ID"
  type        = string
}

variable "oncall_member_1" {
  description = "First on-call team member account ID"
  type        = string
}

variable "oncall_member_2" {
  description = "Second on-call team member account ID"
  type        = string
}
