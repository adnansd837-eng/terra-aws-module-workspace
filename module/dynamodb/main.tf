resource "aws_dynamodb_table" "my_dynamodb_table" {
  count = var.dynamodb_table_count

  name         = "${var.dynamodb_table_name}-${count.index + 1}"
  billing_mode = var.dynamo_billing_mode
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${var.dynamodb_table_name}-${count.index + 1}"
    Environment = var.env
  }
}
