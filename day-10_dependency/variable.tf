variable "aws_s3_bucket" {
    type = string
    default = ""
  
}

variable "ami" {
    type = string
    default = "ami-0c80e2b6ccb9ad6d1"

}

variable "instance_type" {
    type = string
    default = "t2.micro"
  
}

variable "key_name" {
    type = string
    default = "mine"
  
}