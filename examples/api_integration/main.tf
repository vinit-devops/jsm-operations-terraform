# Example: Creating an API Integration

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

module "api_integration" {
  source = "../../api_integration"

  api_integration = {
    name    = "Monitoring System Integration"
    type    = "API"
    enabled = true
    team_id = var.team_id # Optional

    # Type-specific properties vary by integration type
    type_specific_properties = {
      webhook_url = "https://api.example.com/webhook"
      auth_method = "bearer"
    }
  }
}
