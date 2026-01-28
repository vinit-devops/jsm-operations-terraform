# Alert Policy Module

This module creates and manages JSM Operations alert policies for routing and processing alerts.

## Usage

```hcl
module "alert_policy" {
  source = "./alert_policy"

  alert_policy = {
    name        = "Critical Alerts"
    description = "Route critical alerts to on-call team"
    enabled     = true
    message     = "Critical alert: {{message}}"
    filter = {
      type = "match-all"
      conditions = [
        {
          field          = "priority"
          operation      = "equals"
          expected_value = "P1"
          order          = 1
        }
      ]
    }
    actions = ["notify-team"]
    tags    = ["critical", "oncall"]
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
| enabled | Whether to create this alert policy | `bool` | `true` | no |
| alert_policy | Configuration for a single JSM Operations alert policy | `object` | n/a | yes |
| alert_policy.name | Name of the alert policy | `string` | n/a | yes |
| alert_policy.description | Description of the alert policy | `string` | `null` | no |
| alert_policy.team_id | ID of the team this policy applies to | `string` | `null` | no |
| alert_policy.type | Type of policy (e.g., "alert") | `string` | `"alert"` | no |
| alert_policy.enabled | Whether the policy is enabled | `bool` | `true` | no |
| alert_policy.message | Alert message template | `string` | `"{{message}}"` | no |
| alert_policy.filter | Filter configuration for matching alerts | `object` | See below | no |
| alert_policy.actions | List of action IDs to execute | `list(string)` | `[]` | no |
| alert_policy.tags | List of tags to apply | `list(string)` | `[]` | no |
| alert_policy.details | Additional details as key-value pairs | `map(string)` | `{}` | no |
| alert_policy.continue | Whether to continue processing after this policy | `bool` | `false` | no |
| alert_policy.update_priority | Whether to update alert priority | `bool` | `false` | no |
| alert_policy.priority_value | Priority value to set if update_priority is true | `string` | `null` | no |
| alert_policy.keep_original_responders | Keep original responders | `bool` | `false` | no |
| alert_policy.keep_original_details | Keep original details | `bool` | `false` | no |
| alert_policy.keep_original_actions | Keep original actions | `bool` | `false` | no |
| alert_policy.keep_original_tags | Keep original tags | `bool` | `false` | no |

### Filter Object

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| type | Filter type (e.g., "match-all", "match-any") | `string` | `"match-all"` | no |
| conditions | List of filter conditions | `list(object)` | `[]` | no |

### Condition Object

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| field | Field to filter on | `string` | n/a | yes |
| operation | Operation (e.g., "equals", "contains") | `string` | n/a | yes |
| expected_value | Expected value to match | `string` | n/a | yes |
| not | Negate the condition | `bool` | `false` | no |
| order | Order of the condition | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the created JSM Operations alert policy |
| name | Name of the alert policy |

## Examples

### Basic Alert Policy

```hcl
module "alert_policy" {
  source = "./alert_policy"

  alert_policy = {
    name        = "All Alerts"
    description = "Default alert policy"
    enabled     = true
  }
}
```

### Alert Policy with Filter

```hcl
module "alert_policy" {
  source = "./alert_policy"

  alert_policy = {
    name        = "Production Critical"
    description = "Route production critical alerts"
    enabled     = true
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
    actions = ["escalate-to-oncall"]
    tags    = ["production", "critical"]
  }
}
```

### Alert Policy with Priority Update

```hcl
module "alert_policy" {
  source = "./alert_policy"

  alert_policy = {
    name            = "High Priority Alerts"
    description     = "Set high priority for specific alerts"
    enabled         = true
    update_priority = true
    priority_value  = "P1"
    filter = {
      type = "match-all"
      conditions = [
        {
          field          = "source"
          operation      = "equals"
          expected_value = "monitoring-system"
        }
      ]
    }
  }
}
```

## Notes

- Alert policies are processed in order, so the first matching policy will be applied
- Use `continue = true` to allow multiple policies to process the same alert
- Filter conditions support various operations: equals, contains, starts-with, ends-with, etc.
- The `team_id` can be set to scope the policy to a specific team
