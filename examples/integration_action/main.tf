# Example: Creating an Integration Action

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

module "integration_action" {
  source = "../../integration_action"

  integration_id = var.integration_id
  name           = "Create Alert from Monitoring"
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
        not            = false
        order          = 1
      }
    ]
  }

  type_specific_properties = {
    alert_type = "standard"
    auto_close = false
  }

  field_mappings = {
    message  = "{{message}}"
    priority = "{{priority}}"
    source   = "{{source}}"
    tags     = "{{tags}}"
  }
}
