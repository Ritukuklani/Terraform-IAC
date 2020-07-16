#Output is a list of resources
//output "neo_arn" {
//  value       = aws_iam_user.example[0].arn
//  description = "The ARN for user Neo"
//}
//
//output "all_arns" {
//  value       = aws_iam_user.example[*].arn
//  description = "The ARNs for all users"
//}

#Output is a map of resources
//output "all_users" {
//  value = aws_iam_user.example
//}
//
//output "all_arns" {
//  value = values(aws_iam_user.example)[*].arn
//}

#Using the for expression in terraform
//output "short_upper_names" {
//  value = [for name in var.user_names : upper(name) if length(name) < 5]
//}

#Using the for expression with map
//output "bios" {
//  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
//}
//
//output "upper_roles" {
//  value = {for name, role in var.hero_thousand_faces : upper(name) => upper(role)}
//}