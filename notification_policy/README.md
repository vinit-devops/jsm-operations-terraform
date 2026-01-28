# Notification Policy Module

This module creates and manages JSM Operations notification policies for configuring user/team notification rules and auto-close actions.

## Usage

```hcl
module "notification_policy" {
  source = "./notification_policy"

  notification_policy = {
    name        = "Business Hours Notifications"
    description = "Notify team during business hours only"
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
      wait_duration   = 24
      duration_format = "hours"
    }
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
| enabled | Whether to create this notification policy | `bool` | `true` | no |
| notification_policy | Configuration for a single JSM Operations notification policy | `object` | n/a | yes |
| notification_policy.name | Name of the notification policy | `string` | n/a | yes |
| notification_policy.description | Description of the notification policy | `string` | `null` | no |
| notification_policy.enabled | Whether the policy is enabled | `bool` | `true` | no |
| notification_policy.team_id | ID of the team this policy applies to | `string` | n/a | yes |
| notification_policy.filter | Filter configuration for matching alerts | `object` | n/a | yes |
| notification_policy.auto_close_action | Auto-close action configuration | `object` | n/a | yes |

### Filter Object

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| type | Filter type (e.g., "match-all", "match-any") | `string` | `"match-all"` | no |
| conditions | List of filter conditions | `list(object)` | n/a | yes |

### Condition Object

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| field | Field to filter on | `string` | n/a | yes |
| operation | Operation (e.g., "equals", "contains") | `string` | n/a | yes |
| expected_value | Expected value to match | `string` | n/a | yes |
| not | Negate the condition | `bool` | `false` | no |
| order | Order of the condition | `number` | `null` | no |

### Auto-Close Action Object

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| wait_duration | Duration to wait before auto-closing | `number` | n/a | yes |
| duration_format | Format of the duration (e.g., "hours", "days", "minutes") | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the created JSM Operations notification policy |
| name | Name of the notification policy |

## Examples

### Basic Notification Policy

```hcl
module "notification_policy" {
  source = "./notification_policy"

  notification_policy = {
    name        = "Default Notifications"
    description = "Default notification policy"
    enabled     = true
    team_id     = "team-id-123"
    filter = {
      type       = "match-all"
      conditions = []
    }
    auto_close_action = {
      wait_duration   = 48
      duration_format = "hours"
    }
  }
}
```

### Notification Policy with Filter

```hcl
module "notification_policy" {
  source = "./notification_policy"

  notification_policy = {
    name        = "Critical Alerts Only"
    description = "Notify only for critical alerts"
    enabled     = true
    team_id     = module.team.id
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
      wait_duration   = 72
      duration_format = "hours"
    }
  }
}
```

### Notification Policy with Auto-Close

```hcl
module "notification_policy" {
  source = "./notification_policy"

  notification_policy = {
    name        = "Auto-Close Resolved"
    description = "Auto-close resolved alerts after 24 hours"
    enabled     = true
    team_id     = "team-id-123"
    filter = {
      type = "match-all"
      conditions = [
        {
          field          = "status"
          operation      = "equals"
          expected_value = "resolved"
        }
      ]
    }
    auto_close_action = {
      wait_duration   = 24
      duration_format = "hours"
    }
  }
}
```

## Notes

- Notification policies control when and how team members are notified about alerts
- The `team_id` is required and must reference an existing team
- Auto-close actions automatically close alerts after the specified duration
- Filter conditions allow fine-grained control over which alerts trigger notifications
- The `duration_format` can be "minutes", "hours", or "days"
