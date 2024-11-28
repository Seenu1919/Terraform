resource "aws_instance" "ss" {
ami = "ami-0942ecd5d85baa812"
instance_type = "t2.micro"
key_name = "hell"
  
}