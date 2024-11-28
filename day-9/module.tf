module "name" {
    source = "../day-2"
    ami = "ami-0c80e2b6ccb9ad6d1"
    instance_type = "t2.micro"
    key_name = "mine"
    availability_zone = "us-east-2a"
  
}