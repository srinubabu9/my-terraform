provider "aws" {
  profile    = "terraform-user"
  access_key = "AKIAVXKEPQ5KEVVA6I7S"
  secret_key = "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"
  region     = "ap-northeast-1"
}

resource "aws_instance" "linux" {
  ami = "ami-02a2700d37baeef8b"
  tags = {
    Name = "web-server-computer"
  }
  instance_type   = "t2.micro"
  key_name        = "web-sevrer-linux"
  security_groups = ["${aws_security_group.allow_ssh_httpd.name}"]

  # user data in aws ec2 instance by using terraform
  user_data = file("script.sh")
}
resource "aws_security_group" "allow_ssh_httpd" {
  tags = {
    Name = "Allow_SSh_HTTPD"
  }
  name        = "allow_ssh_httpd"
  description = "allow ssh and httpd traffic"
  vpc_id      = "vpc-02c0209c4b79e0376"

  ingress {
    description      = "allow ssh from vpc"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "alllow httpd from vpc"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

