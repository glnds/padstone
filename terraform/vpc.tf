
provider "aws" {
  region = "eu-west-1"
  profile = "pixxis"
}

resource "aws_vpc" "olympus" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "vpc_oly"
  }
}

resource "aws_internet_gateway" "oly_gw" {
  vpc_id = "${aws_vpc.olympus.id}"
  tags {
    Name = "oly_internet_gw"
  }
}

resource "aws_subnet" "oly_public_1a" {
  vpc_id = "${aws_vpc.olympus.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  tags {
    Name = "oly_public_1a"
  }
}

resource "aws_route_table" "rt_public_oly" {
  vpc_id = "${aws_vpc.olympus.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.oly_gw.id}"
  }
  tags {
    Name = "rt_public_oly"
  }
}

resource "aws_route_table_association" "association" {
  subnet_id = "${aws_subnet.oly_public_1a.id}"
  route_table_id = "${aws_route_table.rt_public_oly.id}"
}

resource "aws_security_group" "allow_all" {
  name = "allow_all"
  description = "allow all traffic"
  vpc_id = "${aws_vpc.olympus.id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_all"
  }
}
