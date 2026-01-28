# Complete Example

This example demonstrates how to use multiple JSM Operations modules together to create a complete on-call setup.

## What This Example Creates

1. **Team** - A platform engineering on-call team with members
2. **API Integration** - Integration for receiving alerts from external systems (e.g., Prometheus)
3. **Email Integration** - Integration for receiving alerts via email
4. **Integration Action** - Action to process incoming API alerts
5. **Alert Policies** - Policies for routing critical and warning alerts
6. **Notification Policy** - Policy for managing notifications and auto-close behavior

## Usage

1. Set your variables in `terraform.tfvars`:

```hcl
jsm_ops_api_key  = "your-api-key"
organization_id  = "your-org-id"
oncall_member_1  = "account-id-1"
oncall_member_2  = "account-id-2"
```

2. Initialize and apply:

```bash
terraform init
terraform plan
terraform apply
```

## Outputs

After applying, you'll get:
- Team ID
- Integration IDs and API keys
- Alert policy IDs
- Notification policy ID

These can be used to reference resources in other configurations or to integrate with external systems.
