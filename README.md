# JSM Operations Terraform Modules

This repository contains Terraform modules for managing **Jira Service Management (JSM) Operations** resources in a consistent and automated way. The modules centralize configuration for teams, integrations, alert policies, and notification policies, ensuring governance and reusability across environments.

## Overview

These modules provide a standardized way to manage JSM Operations infrastructure using the [Atlassian Operations Terraform Provider](https://registry.terraform.io/providers/atlassian/atlassian-operations/latest/docs). Each module is designed to be reusable, well-documented, and follows Terraform best practices.

## Available Modules

- **[`team`](./team)** - Create and manage JSM Operations teams and their members
- **[`alert_policy`](./alert_policy)** - Define and manage alert policies for incident routing
- **[`notification_policy`](./notification_policy)** - Configure user/team notification rules and auto-close actions
- **[`api_integration`](./api_integration)** - Manage API integrations for external systems
- **[`email_integration`](./email_integration)** - Manage email integrations for alert ingestion
- **[`integration_action`](./integration_action)** - Define integration actions for processing alerts and incidents

## Requirements

- **Terraform** >= 1.5.0
- **Atlassian Operations Provider** ~> 1.0
- **JSM Operations API Key** with required permissions

## Quick Start

### Provider Configuration

Configure the Atlassian Operations provider in your Terraform configuration:

```hcl
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
  # Optional: base_url = "https://api.atlassian.com"
}
```

### Example Usage

```hcl
module "team" {
  source = "./team"

  organization_id = "your-org-id"
  team = {
    display_name = "Platform Engineering"
    description  = "Platform engineering team"
    members = [
      { id = "account-id-1" },
      { id = "account-id-2" }
    ]
  }
}

module "alert_policy" {
  source = "./alert_policy"

  alert_policy = {
    name        = "Critical Alerts"
    description = "Route critical alerts to on-call team"
    enabled     = true
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
    actions = ["notify-team"]
  }
}
```

## Module Documentation

Each module includes detailed documentation:

- [Team Module](./team/README.md)
- [Alert Policy Module](./alert_policy/README.md)
- [Notification Policy Module](./notification_policy/README.md)
- [API Integration Module](./api_integration/README.md)
- [Email Integration Module](./email_integration/README.md)
- [Integration Action Module](./integration_action/README.md)

## Examples

See the [examples](./examples) directory for complete usage examples of each module and how to combine multiple modules together.

## Authentication

The modules require a JSM Operations API key. You can obtain this from your Atlassian organization settings. Set it as an environment variable or in your Terraform variables:

```bash
export ATLASSIAN_OPERATIONS_API_KEY="your-api-key"
```

Or use a Terraform variable:

```hcl
variable "jsm_ops_api_key" {
  description = "JSM Operations API Key"
  type        = string
  sensitive   = true
}
```

## Resources

- [Atlassian Operations Provider Documentation](https://registry.terraform.io/providers/atlassian/atlassian-operations/latest/docs)
- [Provider GitHub Repository](https://github.com/atlassian/terraform-provider-atlassian-operations)
- [JSM Operations Documentation](https://support.atlassian.com/jira-service-management-cloud/docs/)

## Contributing

Contributions are welcome! Please ensure that:

- All modules follow the established structure and naming conventions
- Documentation is updated for any changes
- Examples are provided for new features
- Code follows Terraform best practices

## License

See [LICENSE](./LICENSE) file for details.

