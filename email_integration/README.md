# Email Integration Module

This module creates and manages JSM Operations email integrations for receiving alerts via email.

## Usage

```hcl
module "email_integration" {
  source = "./email_integration"

  email_integration = {
    name            = "Alerts Email"
    email_username  = "cloud-fortified-alerts"
    enabled         = true
    suppress_notifications = false
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| atlassian-operations | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| atlassian-operations | ~> 1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enabled | Whether to create this email integration | `bool` | `true` | no |
| email_integration | Configuration for a single JSM Operations email integration | `object` | n/a | yes |
| email_integration.name | Name of the email integration | `string` | n/a | yes |
| email_integration.email_username | Email username for this integration | `string` | n/a | yes |
| email_integration.enabled | Whether the integration is enabled | `bool` | `true` | no |
| email_integration.suppress_notifications | Whether to suppress notifications | `bool` | `false` | no |
| email_integration.team_id | ID of the team this integration belongs to | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the email integration |
| name | Name of the email integration |

## Examples

### Basic Email Integration

```hcl
module "email_integration" {
  source = "./email_integration"

  email_integration = {
    name           = "Production Alerts"
    email_username = "prod-alerts"
    enabled        = true
  }
}
```

### Email Integration with Team

```hcl
module "email_integration" {
  source = "./email_integration"

  email_integration = {
    name            = "Team Email Integration"
    email_username  = "team-alerts"
    enabled         = true
    team_id         = module.team.id
    suppress_notifications = false
  }
}
```

### Email Integration with Suppressed Notifications

```hcl
module "email_integration" {
  source = "./email_integration"

  email_integration = {
    name                 = "Silent Email Integration"
    email_username        = "silent-alerts"
    enabled              = true
    suppress_notifications = true
  }
}
```

## Notes

- The `email_username` is used to generate the email address for the integration (e.g., `cloud-fortified-alerts@opsgenie.net`)
- Email integrations allow you to receive alerts by sending emails to the generated address
- The `team_id` can be set to associate the integration with a specific team
- When `suppress_notifications` is true, notifications will not be sent for alerts received via this integration
- The `team_id` is immutable after creation, so changes will be ignored via lifecycle rules
