# Example: Creating an Alert Policy

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

module "alert_policy" {
  source = "../../alert_policy"

  alert_policy = {
    name        = "Production Critical Alerts"
    description = "Route production critical alerts to on-call team"
    enabled     = true
    message     = "🚨 Critical Alert: {{message}}"
    team_id     = var.team_id # Optional: scope to specific team

    filter = {
      type = "match-all"
      conditions = [
        {
          field          = "environment"
          operation      = "equals"
          expected_value = "production"
          order          = 1
        },
        {
          field          = "severity"
          operation      = "equals"
          expected_value = "critical"
          order          = 2
        }
      ]
    }

    actions = ["notify-team", "escalate"]
    tags    = ["production", "critical", "oncall"]

    update_priority = true
    priority_value  = "P1"
  }
}
