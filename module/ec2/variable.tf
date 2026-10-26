variable "env" {
  description = "this is variable holds module dev"
  type    = string
  
}

variable "ec2_volume_size" {    #
  type        = number
  default     = "20"
  description = "this variable holds volume size"
}

variable "my_ec2_instance_name" {   #
    type = string
    default = "terra-auto-server"
}

variable "ec2_key_pair" {    #
    type = string 
    default = "terraform-module-key.pub"
}

variable "ec2_ami_id" {     #
    type = string
    default = "099720109477"
    description = "this variable holds ami owner id"
}

variable "ec2_instance_type" {   #
    type = string
    default = "t3.micro"
    description = "this variable holds the instance type"
}

variable "ec2_instance_count" {   #
    type = number
    default = 1
    description = "this variable holds the instance count"
}
