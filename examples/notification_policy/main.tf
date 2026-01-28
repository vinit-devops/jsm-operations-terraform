# Example: Creating a Notification Policy

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

module "notification_policy" {
  source = "../../notification_policy"

  notification_policy = {
    name        = "Business Hours Notifications"
    description = "Notify team only during business hours for critical alerts"
    enabled     = true
    team_id     = var.team_id

    filter = {
      type = "match-all"
      conditions = [
        {
          field          = "priority"
          operation      = "equals"
          expected_value = "P1"
        },
        {
          field          = "status"
          operation      = "equals"
          expected_value = "open"
        }
      ]
    }

    auto_close_action = {
      wait_duration   = 48
      duration_format = "hours"
    }
  }
}
