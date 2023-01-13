locals {
  time_period_start = var.time_period_start != null ? var.time_period_start : formatdate("YYYY-MM-DD_hh:mm", timestamp())
}
resource "aws_budgets_budget" "budget" {
  name              = var.name
  budget_type       = var.budget_type
  limit_amount      = var.limit_amount
  limit_unit        = var.limit_unit
  time_period_end   = var.time_period_end
  time_period_start = local.time_period_start
  time_unit         = var.time_unit
  dynamic "notification" {
    for_each = var.notification
    iterator = item #optional
    content {
      comparison_operator        = item.value.comparison_operator
      threshold                  = item.value.threshold
      threshold_type             = item.value.threshold_type
      notification_type          = item.value.notification_type
      subscriber_email_addresses = item.value.subscriber_email_addresses
      subscriber_sns_topic_arns  = item.value.subscriber_sns_topic_arns
    }
  }
  dynamic "cost_types" {
    for_each = var.cost_types
    iterator = item #optional
    content {
      include_credit             = item.value.include_credit
      include_discount           = item.value.include_discount
      include_other_subscription = item.value.include_other_subscription
      include_recurring          = item.value.include_recurring
      include_refund             = item.value.include_refund
      include_subscription       = item.value.include_subscription
      include_support            = item.value.include_support
      include_tax                = item.value.include_tax
      include_upfront            = item.value.include_upfront
      use_amortized              = item.value.use_amortized
      use_blended                = item.value.use_blended
    }
  }
  dynamic "cost_filter" {
    for_each = var.cost_filter
    content {
      name   = cost_filter.value.name
      values = [cost_filter.value.values]
    }
  }
}
