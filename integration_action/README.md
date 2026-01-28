# Integration Action Module

This module creates and manages JSM Operations integration actions for processing alerts and incidents through integrations.

## Usage

```hcl
module "integration_action" {
  source = "./integration_action"

  integration_id = module.api_integration.id
  name           = "Create Alert"
  type           = "create"
  domain         = "alert"
  direction      = "incoming"
  filter = {
    condition_match_type = "match-all"
    conditions = [
      {
        field          = "source"
        operation      = "equals"
        expected_value = "monitoring"
      }
    ]
  }
  type_specific_properties = {
    alert_type = "standard"
  }
  field_mappings = {
    message = "{{message}}"
    priority = "{{priority}}"
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
| enabled | Whether to create this integration action | `bool` | `true` | no |
| integration_id | ID of the integration this action belongs to | `string` | n/a | yes |
| name | Name of the integration action | `string` | n/a | yes |
| type | Type of the integration action (e.g., "create", "update") | `string` | n/a | yes |
| domain | Domain of the integration action (e.g., "alert", "incident") | `string` | n/a | yes |
| direction | Direction of the integration action (e.g., "incoming", "outgoing") | `string` | n/a | yes |
| filter | Filter configuration for the integration action | `object` | n/a | yes |
| type_specific_properties | Type-specific properties (will be JSON encoded) | `any` | `{}` | no |
| field_mappings | Field mappings (will be JSON encoded) | `any` | `{}` | no |

### Filter Object

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| condition_match_type | How conditions are matched (e.g., "match-all", "match-any") | `string` | `"match-all"` | no |
| conditions_empty | Whether conditions list is empty | `bool` | `false` | no |
| conditions | List of filter conditions | `list(object)` | n/a | yes |

### Condition Object

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| field | Field to filter on | `string` | n/a | yes |
| operation | Operation (e.g., "equals", "contains") | `string` | n/a | yes |
| expected_value | Expected value to match | `string` | n/a | yes |
| not | Negate the condition | `bool` | `false` | no |
| order | Order of the condition | `number` | `null` | no |
| system_condition | Whether this is a system condition | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the integration action |
| name | Name of the integration action |
| integration_id | ID of the integration this action belongs to |

## Examples

### Basic Integration Action

```hcl
module "integration_action" {
  source = "./integration_action"

  integration_id = "integration-id-123"
  name           = "Create Alert Action"
  type           = "create"
  domain         = "alert"
  direction      = "incoming"
  filter = {
    condition_match_type = "match-all"
    conditions = []
  }
}
```

### Integration Action with Filter

```hcl
module "integration_action" {
  source = "./integration_action"

  integration_id = module.api_integration.id
  name           = "Filtered Create Action"
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
      },
      {
        field          = "severity"
        operation      = "equals"
        expected_value = "critical"
        not            = false
        order          = 1
      }
    ]
  }
}
```

### Integration Action with Field Mappings

```hcl
module "integration_action" {
  source = "./integration_action"

  integration_id = module.api_integration.id
  name           = "Mapped Create Action"
  type           = "create"
  domain         = "alert"
  direction      = "incoming"
  filter = {
    condition_match_type = "match-all"
    conditions = []
  }
  field_mappings = {
    message  = "{{message}}"
    priority = "{{priority}}"
    source   = "{{source}}"
    tags     = "{{tags}}"
  }
  type_specific_properties = {
    alert_type = "standard"
    auto_close = false
  }
}
```

### Outgoing Integration Action

```hcl
module "integration_action" {
  source = "./integration_action"

  integration_id = module.api_integration.id
  name           = "Outgoing Webhook"
  type           = "create"
  domain         = "alert"
  direction      = "outgoing"
  filter = {
    condition_match_type = "match-all"
    conditions = [
      {
        field          = "priority"
        operation      = "equals"
        expected_value = "P1"
      }
    ]
  }
  type_specific_properties = {
    webhook_url = "https://api.example.com/webhook"
    method      = "POST"
  }
}
```

## Notes

- Integration actions define how alerts/incidents are processed through integrations
- The `integration_id` must reference an existing integration (API or email)
- `direction` can be "incoming" (alerts coming into JSM) or "outgoing" (alerts going out from JSM)
- `domain` specifies whether the action applies to "alert" or "incident" objects
- `type_specific_properties` and `field_mappings` are automatically JSON encoded
- Filter conditions allow fine-grained control over when actions are triggered
- Field mappings use template syntax (e.g., `{{message}}`) to map integration data to JSM fields
