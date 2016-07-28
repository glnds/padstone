variable "ami" {}
variable "subnet" {}
variable "security_group" {}
variable "name" {}
variable "stack" {}
variable "zone_id" {}
variable "eip_allocation_id" {}
variable "eip_ip" {}
variable "dns_name" {}

provider "aws" {
  region = "eu-west-1"
  profile = "pixxis"
}

resource "aws_instance" "playground" {
  ami = "${var.ami}"
  instance_type = "t2.micro"
  subnet_id = "${var.subnet}"
  disable_api_termination = false
  key_name = "glnds"
  associate_public_ip_address = false

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

resource "aws_eip_association" "eip_assoc" {
  instance_id = "${aws_instance.playground.id}"
  allocation_id = "${var.eip_allocation_id}"
}

resource "aws_route53_record" "playground" {
   zone_id = "${var.zone_id}"
   name = "${var.dns_name}"
   type = "A"
   ttl = "300"
   records = ["${var.eip_ip}"]
}
