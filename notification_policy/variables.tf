variable "notification_policy" {
  type = object({
    enabled     = bool
    name        = string
    team_id     = string
    description = string
    filter = object({
      type       = string
      conditions = list(object({
        field          = string
        operation      = string
        expected_value = string
      }))
    })
    auto_close_action = object({
      wait_duration   = number
      duration_format = string
    })
  })
}