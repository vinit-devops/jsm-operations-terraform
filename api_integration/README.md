# API Integration Module

This module creates and manages JSM Operations API integrations for connecting external systems.

## Usage

```hcl
module "api_integration" {
  source = "./api_integration"

  api_integration = {
    name    = "Monitoring System Integration"
    type    = "API"
    enabled = true
    type_specific_properties = {
      api_key = "your-api-key"
      base_url = "https://api.example.com"
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
| enabled | Whether to create this API integration | `bool` | `true` | no |
| api_integration | Configuration for a single JSM Ops API integration | `object` | n/a | yes |
| api_integration.name | Name of the API integration | `string` | n/a | yes |
| api_integration.type | Type of the API integration | `string` | n/a | yes |
| api_integration.enabled | Whether the integration is enabled | `bool` | `true` | no |
| api_integration.delete_default_actions | Whether to delete default actions | `bool` | `false` | no |
| api_integration.team_id | ID of the team this integration belongs to | `string` | `null` | no |
| api_integration.type_specific_properties | Type-specific properties (will be JSON encoded) | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the API integration |
| api_key | API key for the integration (only after first create, sensitive) |
| name | Name of the API integration |
| type | Type of the API integration |

## Examples

### Basic API Integration

```hcl
module "api_integration" {
  source = "./api_integration"

  api_integration = {
    name = "External Monitoring"
    type = "API"
  }
}
```

### API Integration with Team

```hcl
module "api_integration" {
  source = "./api_integration"

  api_integration = {
    name    = "Team Integration"
    type    = "API"
    enabled = true
    team_id = module.team.id
  }
}
```

### API Integration with Type-Specific Properties

```hcl
module "api_integration" {
  source = "./api_integration"

  api_integration = {
    name    = "Custom Integration"
    type    = "API"
    enabled = true
    type_specific_properties = {
      endpoint    = "https://api.example.com/webhook"
      auth_method = "bearer"
      headers = {
        "X-Custom-Header" = "value"
      }
    }
  }
}
```

### API Integration with Default Actions Deleted

```hcl
module "api_integration" {
  source = "./api_integration"

  api_integration = {
    name                  = "Clean Integration"
    type                  = "API"
    delete_default_actions = true
  }
}
```

## Notes

- The `api_key` output is only available after the initial creation and is sensitive
- The `team_id` is immutable after creation, so changes will be ignored via lifecycle rules
- `type_specific_properties` accepts any object/map and will be JSON encoded automatically
- Different integration types may require different properties in `type_specific_properties`
- Use `delete_default_actions = true` to remove default actions that are created automatically
