
locals {
  env =  {
  dev = {
    instance_count = 1
    bucket_count = 1
    table_count = 1

  }

  stg = {
    instance_count = 2
    bucket_count = 2
    table_count = 1

  }

  prd = {
    instance_count = 2
    bucket_count = 1
    table_count = 2
  }
  }
  current = lookup(local.env, terraform.workspace, local.env["dev"])
}

 
  module "dev-infra" {
    source              = "./module/ec2"
    env                 = terraform.workspace
    ec2_instance_count  = local.current.instance_count
  }

  module "stg-infra" {
    source          = "./module/s3"
    env             = terraform.workspace
    s3_bucket_count = local.current.bucket_count
  }

  module "prd-infra" {
    source               = "./module/dynamodb"
    env                  = terraform.workspace
    dynamodb_table_count = local.current.table_count
  }
