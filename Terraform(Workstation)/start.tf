provider "aws" {
  region     = "eu-north-1"
  secret_key = var.aws_secret_key
  access_key = var.aws_access_key
}
resource "aws_security_group" "TFDefault" {
   name   = "TFDefault_Security_Group"
   vpc_id = aws_default_vpc.default.id

   dynamic "ingress" {
     for_each = ["80","22"]
     content {
       from_port   = ingress.value
       to_port     = ingress.value
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
     }
   }
   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
     "Name" = "Workstation_SG"
   }
 }

 resource "aws_default_vpc" "default" {}
 
 resource "aws_instance" "Workstation"{
     ami = "ami-09e1162c87f73958b"
     instance_type = "t3.micro"
     key_name = "Stockholm_RSA"
     tags = {
       "Name" = "MYSQL_Server"
     }
    
     vpc_security_group_ids = [aws_security_group.TFDefault.id]
     ebs_block_device {
       device_name = "/dev/sda1"
       volume_type ="gp3"
       volume_size = 20
       encrypted = true
       delete_on_termination = true

     }
 }