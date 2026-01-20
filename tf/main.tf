provider "aws" {
  region = "us-east-2" 
}

resource "aws_instance" "US_EAST_EC2" {
  ami           = "ami-05fb0b8c1424f266b" 
  instance_type = "t2.micro"

  tags = {
    Name = "Created-by-Terraform"
  }
}