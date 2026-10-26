#Variables you change values without changing your code.
variable "env" {
  description = "this is variable holds module dev"
  type    = string
  
}

variable "s3_bucket_name" {
  type        = string
  default     = "terra-s3-bucket"
  description = "this variable holds the s3 bucket name"
}

variable "s3_bucket_count" {   #
    type = number
    default = 1
    description = "this variable holds the s3 count"

}
