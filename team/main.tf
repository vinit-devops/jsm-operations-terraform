resource "atlassian-operations_team" "this" {
  count = var.enabled ? 1 : 0

  organization_id = var.organization_id
  display_name    = var.team.display_name
  description     = try(var.team.description, var.team.display_name)
  team_type       = "MEMBER_INVITE"

  member = [
    for m in try(var.team.members, []) : {
      account_id = m.id
    }
  ]
}

