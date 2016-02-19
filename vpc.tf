
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

resource "aws_iam_role" "ecsInstanceRole" {
  name = "ecsInstanceRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "AmazonEC2ContainerServiceforEC2Role" {
    name = "AmazonEC2ContainerServiceforEC2Role"
    roles = ["${aws_iam_role.ecsInstanceRole.name}"]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
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
