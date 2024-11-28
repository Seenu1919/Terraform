resource "aws_s3_bucket" "muin" {
    bucket = var.aws_s3_bucket
  
}

resource "aws_instance" "name" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    depends_on = [ aws_instance.name ]
  
}