output "budget_name" {
  value       = aws_budgets_budget.budget.name
  description = "The name of the Budget."
}