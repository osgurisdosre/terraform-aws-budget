variable "name" {
  description = "The name of a budget. Unique within accounts."
  type        = string
}
variable "budget_type" {
  description = "Whether this budget tracks monetary cost or usage."
  type        = string
  default     = "COST"
}
variable "limit_amount" {
  description = "The name of a budget. Unique within accounts."
  type        = number
}
variable "limit_unit" {
  description = "The unit of measurement used for the budget forecast, actual spend, or budget threshold, such as dollars or GB."
  type        = string
  default     = "USD"
}
variable "time_unit" {
  description = ") The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY."
  type        = string
  default     = "MONTHLY"
}
variable "time_period_start" {
  description = "The start of the time period covered by the budget. If you don't specify a start date, AWS defaults to the start of your chosen time period. The start date must come before the end date. Format: 2017-01-01_12:00."
  type        = string
  default     = null
}
variable "time_period_end" {
  description = "The unit of measurement used for the budget forecast, actual spend, or budget threshold, such as dollars or GB."
  type        = string
  default     = "2087-06-15_00:00"
}

variable "notification" {
  description = "list of values to notification"
  type = list(object({
    comparison_operator        = string
    threshold                  = number
    threshold_type             = string
    notification_type          = string
    subscriber_email_addresses = optional(list(string))
    subscriber_sns_topic_arns  = optional(list(string))
  }))
}
variable "cost_types" {
  description = "Whether this budget tracks monetary cost or usage."
  default = [{
    include_credit             = true
    include_discount           = true
    include_other_subscription = true
    include_recurring          = true
    include_refund             = true
    include_subscription       = true
    include_support            = true
    include_tax                = true
    include_upfront            = true
    use_amortized              = false
    use_blended                = false
  }]
  type = list(object({
    include_discount           = optional(bool)
    include_other_subscription = optional(bool)
    include_recurring          = optional(bool)
    include_refund             = optional(bool)
    include_subscription       = optional(bool)
    include_support            = optional(bool)
    include_tax                = optional(bool)
    use_amortized              = optional(bool)
    include_upfront            = optional(bool)
    use_blended                = optional(bool)
    include_credit             = optional(bool)
  }))
}
variable "cost_filter" {
  type        = list(map(string))
  default     = []
  description = "A list of CostFilter name/values pair to apply to budget."
}
