# Terraform modules Budgets

This module seeks to create a Budget for the AWS account, accepting 1 or more alerts, we chose to use email notifications, in view of the practicality.

Below 2 examples of how to use the module, 1 with Terraform another with Terragrunt:

**Terragrunt**
```
name: "budget-aws"
budget_type : "COST"
time_unit   : "MONTHLY"
limit_unit  : "USD"
limit_amount: "1000"
time_period_start: "2022-10-01_00:00"
notification: 
  -  comparison_operator        : "GREATER_THAN"
     threshold                  : 100
     threshold_type             : "PERCENTAGE"
     notification_type          : "FORECASTED"
     subscriber_email_addresses : "abc@xxx.com"
  -
    comparison_operator        : "GREATER_THAN"
    threshold                  : 90
    threshold_type             : "PERCENTAGE"
    notification_type          : "FORECASTED"
    subscriber_email_addresses :
      - "abc@xxx.com"
      - "def@xxx.com"
```

**Terraform**
```
module "budget" {
  source                     = "osgurisdosre/budget/awst"
  name                       = var.name
  budget_type                = var.budget_type["budget_type"]
  limit_amount               = var.limit_amount
  limit_unit                 = var.limit_unit
  time_period_start          = var.time_period_start
  time_unit                  = var.time_unit
  #Accepts various notifications, just add or remove blocks {}
  notification = [
  { 
    comparison_operator = "GREATER_THAN",
    threshold = 100,
    threshold_type = "PERCENTAGE",
    notification_type = "FORECASTED",
    subscriber_email_addresses = ["abc@xxx.com", "def@xxx.com"]
  },
  { 
    comparison_operator = "GREATER_THAN",
    threshold = 97,
    threshold_type = "PERCENTAGE",
    notification_type = "FORECASTED",
    subscriber_email_addresses = ["abc@xxx.com", "def@xxx.com"]
  }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.48 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.budget](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budget_type"></a> [budget\_type](#input\_budget\_type) | Whether this budget tracks monetary cost or usage. | `string` | `"COST"` | no |
| <a name="input_cost_filter"></a> [cost\_filter](#input\_cost\_filter) | A list of CostFilter name/values pair to apply to budget. | `list(map(string))` | `[]` | no |
| <a name="input_cost_types"></a> [cost\_types](#input\_cost\_types) | Whether this budget tracks monetary cost or usage. | <pre>list(object({<br>    include_discount           = optional(bool)<br>    include_other_subscription = optional(bool)<br>    include_recurring          = optional(bool)<br>    include_refund             = optional(bool)<br>    include_subscription       = optional(bool)<br>    include_support            = optional(bool)<br>    include_tax                = optional(bool)<br>    use_amortized              = optional(bool)<br>    include_upfront            = optional(bool)<br>    use_blended                = optional(bool)<br>    include_credit             = optional(bool)<br>  }))</pre> | <pre>[<br>  {<br>    "include_credit": true,<br>    "include_discount": true,<br>    "include_other_subscription": true,<br>    "include_recurring": true,<br>    "include_refund": true,<br>    "include_subscription": true,<br>    "include_support": true,<br>    "include_tax": true,<br>    "include_upfront": true,<br>    "use_amortized": false,<br>    "use_blended": false<br>  }<br>]</pre> | no |
| <a name="input_limit_amount"></a> [limit\_amount](#input\_limit\_amount) | The name of a budget. Unique within accounts. | `number` | n/a | yes |
| <a name="input_limit_unit"></a> [limit\_unit](#input\_limit\_unit) | The unit of measurement used for the budget forecast, actual spend, or budget threshold, such as dollars or GB. | `string` | `"USD"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of a budget. Unique within accounts. | `string` | n/a | yes |
| <a name="input_notification"></a> [notification](#input\_notification) | list of values to notification | <pre>list(object({<br>    comparison_operator        = string<br>    threshold                  = number<br>    threshold_type             = string<br>    notification_type          = string<br>    subscriber_email_addresses = optional(list(string))<br>    subscriber_sns_topic_arns  = optional(list(string))<br>  }))</pre> | n/a | yes |
| <a name="input_time_period_end"></a> [time\_period\_end](#input\_time\_period\_end) | The unit of measurement used for the budget forecast, actual spend, or budget threshold, such as dollars or GB. | `string` | `"2087-06-15_00:00"` | no |
| <a name="input_time_period_start"></a> [time\_period\_start](#input\_time\_period\_start) | The start of the time period covered by the budget. If you don't specify a start date, AWS defaults to the start of your chosen time period. The start date must come before the end date. Format: 2017-01-01\_12:00. | `string` | `null` | no |
| <a name="input_time_unit"></a> [time\_unit](#input\_time\_unit) | ) The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY. | `string` | `"MONTHLY"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_budget_name"></a> [budget\_name](#output\_budget\_name) | The name of the Budget. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Authors

Module is maintained by [Emidio Neto](https://github.com/emdneto), [Leonardo Jardim](https://github.com/leojaardim) and [Yuri Azeredo](https://github.com/yuriazeredo)
## License

Apache 2 Licensed. See [LICENSE](https://github.com/osgurisdosre/terraform-aws-budget/blob/main/LICENSE) for full details.
