output "dynamodb_table_name" {
  value = aws_dynamodb_table.my_dynamodb_table[*].name
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.my_dynamodb_table[*].arn
}

output "dynamodb_table_id" {
  value = aws_dynamodb_table.my_dynamodb_table[*].id
}
