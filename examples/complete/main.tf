# Complete Example: Using Multiple JSM Operations Modules Together
# This example demonstrates how to create a complete JSM Operations setup
# with a team, integrations, alert policies, and notification policies

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

# Step 1: Create a team
module "team" {
  source = "../../team"

  organization_id = var.organization_id
  team = {
    display_name = "Platform Engineering On-Call"
    description  = "Primary on-call team for platform engineering"
    team_type    = "MEMBER_INVITE"
    members = [
      { id = var.oncall_member_1 },
      { id = var.oncall_member_2 }
    ]
  }
}

# Step 2: Create an API integration for external monitoring systems
module "api_integration" {
  source = "../../api_integration"

  api_integration = {
    name    = "Prometheus Integration"
    type    = "API"
    enabled = true
    team_id = module.team.id
  }
}

# Step 3: Create an email integration for email-based alerts
module "email_integration" {
  source = "../../email_integration"

  email_integration = {
    name                 = "Email Alerts"
    email_username       = "platform-alerts"
    enabled              = true
    suppress_notifications = false
    team_id              = module.team.id
  }
}

# Step 4: Create integration actions for the API integration
module "api_integration_action" {
  source = "../../integration_action"

  integration_id = module.api_integration.id
  name           = "Create Alert from API"
  type           = "create"
  domain         = "alert"
  direction      = "incoming"

  filter = {
    condition_match_type = "match-all"
    conditions = [
      {
        field          = "source"
        operation      = "equals"
        expected_value = "prometheus"
      }
    ]
  }

  field_mappings = {
    message  = "{{message}}"
    priority = "{{priority}}"
    source   = "{{source}}"
  }
}

# Step 5: Create alert policies for routing
module "critical_alert_policy" {
  source = "../../alert_policy"

  alert_policy = {
    name        = "Critical Production Alerts"
    description = "Route critical production alerts to on-call team"
    enabled     = true
    message     = "🚨 Critical Alert: {{message}}"
    team_id     = module.team.id

    filter = {
      type = "match-all"
      conditions = [
        {
          field          = "environment"
          operation      = "equals"
          expected_value = "production"
        },
        {
          field          = "severity"
          operation      = "equals"
          expected_value = "critical"
        }
      ]
    }

    actions = ["notify-team"]
    tags    = ["production", "critical", "oncall"]

    update_priority = true
    priority_value  = "P1"
  }
}

module "warning_alert_policy" {
  source = "../../alert_policy"

  alert_policy = {
    name        = "Warning Alerts"
    description = "Route warning alerts during business hours"
    enabled     = true
    team_id     = module.team.id

    filter = {
      type = "match-all"
      conditions = [
        {
          field          = "severity"
          operation      = "equals"
          expected_value = "warning"
        }
      ]
    }

    actions = ["notify-team"]
    tags    = ["warning"]
  }
}

# Step 6: Create notification policies
module "notification_policy" {
  source = "../../notification_policy"

  notification_policy = {
    name        = "Business Hours Notifications"
    description = "Notify team during business hours for critical alerts"
    enabled     = true
    team_id     = module.team.id

    filter = {
      type = "match-all"
      conditions = [
        {
          field          = "priority"
          operation      = "equals"
          expected_value = "P1"
        }
      ]
    }

    auto_close_action = {
      wait_duration   = 48
      duration_format = "hours"
    }
  }
}
