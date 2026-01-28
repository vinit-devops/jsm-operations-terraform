# Example: Creating an Email Integration

terraform {
  required_providers {
    atlassian-operations = {
      source  = "registry.terraform.io/atlassian/atlassian-operations"
      version = "~> 1.0"
    }
  }
}

provider "atlassian-operations" {
  api_key = var.jsm_ops_api_key
}

module "email_integration" {
  source = "../../email_integration"

  email_integration = {
    name                 = "Production Alerts Email"
    email_username       = "prod-alerts"
    enabled              = true
    suppress_notifications = false
    team_id              = var.team_id # Optional
  }
}
