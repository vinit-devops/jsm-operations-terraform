# Team Module

This module creates and manages JSM Operations teams and their members.

## Usage

```hcl
module "team" {
  source = "./team"

  organization_id = "your-org-id"
  team = {
    display_name = "Platform Engineering"
    description  = "Platform engineering team responsible for infrastructure"
    team_type    = "MEMBER_INVITE"
    members = [
      { id = "account-id-1" },
      { id = "account-id-2" }
    ]
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
| enabled | Whether to create this JSM Operations team | `bool` | `true` | no |
| organization_id | ID of the Atlassian organization | `string` | n/a | yes |
| team | Configuration for a single JSM Operations team | `object` | n/a | yes |
| team.display_name | Display name of the team | `string` | n/a | yes |
| team.description | Description of the team | `string` | `null` | no |
| team.team_type | Type of team (e.g., "MEMBER_INVITE") | `string` | `"MEMBER_INVITE"` | no |
| team.members | List of team members | `list(object({id = string}))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the created JSM Operations team |
| name | Display name of the team |
| display_name | Display name of the team (alias for name) |

## Examples

### Basic Team

```hcl
module "team" {
  source = "./team"

  organization_id = "abc123"
  team = {
    display_name = "Engineering Team"
    description  = "Main engineering team"
  }
}
```

### Team with Members

```hcl
module "team" {
  source = "./team"

  organization_id = "abc123"
  team = {
    display_name = "On-Call Team"
    description  = "Primary on-call rotation team"
    members = [
      { id = "5d5e5f6g7h8i9j0k1l2m3n4" },
      { id = "1a2b3c4d5e6f7g8h9i0j1k2" }
    ]
  }
}
```

## Notes

- The `team_id` output can be used as input for other modules (e.g., alert policies, notification policies)
- Team members are identified by their Atlassian account IDs
- The `team_type` defaults to "MEMBER_INVITE" which allows team members to invite others
