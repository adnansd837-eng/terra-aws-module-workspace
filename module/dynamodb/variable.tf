#Variables you change values without changing your code.
variable "env" {
  description = "this is variable holds module dev"
  type    = string
  validation {
    condition     = contains(["dev", "stage", "prod"], var.env)
    error_message = "env must be one of: dev, stage, prod."
  }

}

variable "dynamodb_table_name" {
  type        = string
  default     = "terra-dynamodb-table-2026"
  description = "this variable holds the dynamodb table name"
}

variable "dynamo_billing_mode" {
  type        = string
  default     = "PAY_PER_REQUEST"
  description = "this variable holds the dynamodb billing mode"
}

variable "dynamodb_table_count" {   #
    type = number
    default = 1
    description = "this variable holds the dynamodb table count"
}
