variable "subnet" {}
variable "security_group" {}
variable "name" {}
variable "stack" {}
variable "zone_id" {}


provider "aws" {
  region = "eu-west-1"
  profile = "pixxis"
}

resource "aws_instance" "playground" {
  ami = "ami-7abd0209"
  instance_type = "t2.micro"
  subnet_id = "${var.subnet}"
  disable_api_termination = true
  key_name = "glnds"
  associate_public_ip_address = true

  vpc_security_group_ids = ["${var.security_group}"]

  root_block_device {
    volume_type = "gp2"
    volume_size = 24
    delete_on_termination = true
  }

  tags {
    Name = "${var.name}"
    Stack = "${var.stack}"
    Type = "playground"
  }
}

resource "aws_route53_record" "playground" {
   zone_id = "${var.zone_id}"
   name = "playground"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.playground.public_ip}"]
}
