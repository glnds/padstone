
provider "aws" {
  region = "eu-west-1"
  profile = "pixxis"
}

resource "aws_vpc" "olympus" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "vpr_oly"
  }
  /* tags { */
  /*   Name = "vpc_oly" */
}

resource "aws_subnet" "oly_public_1a" {
  vpc_id = "${aws_vpc.olympus.id}"
  cidr_block = "10.0.1.0/24"
  tags {
    Name = "oly_public_1a"
  }
}
