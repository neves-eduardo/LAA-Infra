provider "aws" {}

data "aws_ami" "laa" {
  owners = ["self"]

  filter {
  name   = "name"
  values = ["laa"]
  }
}

data "aws_ami" "laa-influxdb" {
  owners = ["self"]

  filter {
  name   = "name"
  values = ["laa-influxdb"]
  }
}

resource "aws_security_group" "security-laa" {
  name        = "security-laa"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  ingress {
    from_port   = 8086
    to_port     = 8086
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "laa" {
    instance_type = "t2.micro"
    ami = data.aws_ami.laa.id
    security_groups = [aws_security_group.security-laa.name]
    key_name = "laachallenge1"
      tags = {
    Name = "laa"
  }
}

resource "aws_instance" "laa-influxdb" {
    instance_type = "t2.micro"
    ami = data.aws_ami.laa-influxdb.id
    security_groups = [aws_security_group.security-laa.name]
    key_name = "laachallenge1"
      tags = {
    Name = "laa-influxdb"
  }
}




