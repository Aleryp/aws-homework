terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.0.4"
}

provider "aws" {
  profile    = "default"
  region     = "eu-central-1"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-047e03b8591f2d48a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]

  user_data = <<-EOL
  #!/bin/bash -xe

  apt update
  apt install python --yes
  git copy https://github.com/Aleryp/aws-homework.git
  cd aws-homework/covidfore
  pip install --upgrade pip
  pip install -r requirements.txt
  python run.py
  EOL


  tags = {
    Name = "Academy-EC2"
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 80
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    }
  ]
}
