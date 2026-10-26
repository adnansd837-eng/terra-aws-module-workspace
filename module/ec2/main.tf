#Key Pair
resource "aws_key_pair" "ec2_aws_key_pair" {
  key_name   = "${var.env}-terraform-module-key"
  public_key = file("/home/ubuntu/terraform-aws-module/terraform-module-key.pub")
}
#AMI 
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = [var.ec2_ami_id] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

 
}

#VPC
resource "aws_default_vpc" "default" {

}

#Security group
resource "aws_security_group" "my_ec2_sg" {

  name        = "${var.env}terra-auto-sg"      #dev secruity group
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id    #Interpolation

  tags = {
    Name = "${var.env}-terra-auto-sg}"
  }
}

#Ingress (inbount rule)
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ssh" {
  security_group_id = aws_security_group.my_ec2_sg.id    #interpolation
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_http" {
  security_group_id = aws_security_group.my_ec2_sg.id     #interpolation
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

#Egress (outbound rules)
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my_ec2_sg.id   #interpolation
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#Final instance with all wiring (interpolation)

resource "aws_instance" "my_ec2_instance" {
  count = var.ec2_instance_count            #meta arguments
  ami           = data.aws_ami.ubuntu.id                                        #Interpolation
  instance_type = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.my_ec2_sg.id]      #interpolation
  key_name = aws_key_pair.ec2_aws_key_pair.key_name                      #key_name

  root_block_device {           #storage
    volume_size = var.ec2_volume_size
    volume_type = "gp3"
  }
 
  tags = {
    Name = "${var.env}-${var.my_ec2_instance_name}"
    Environment = var.env
  }
}
