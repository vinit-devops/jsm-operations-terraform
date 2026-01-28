# Example: Creating a JSM Operations Team

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

module "team" {
  source = "../../team"

  organization_id = var.organization_id
  team = {
    display_name = "Platform Engineering"
    description  = "Platform engineering team responsible for infrastructure and reliability"
    team_type    = "MEMBER_INVITE"
    members = [
      { id = var.member_account_id_1 },
      { id = var.member_account_id_2 }
    ]
  }
}
