# this provider information
provider "aws" {
  profile    = "terraform-user"
  access_key = "AKIAVXKEPQ5KEVVA6I7S"
  secret_key = "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"
  region     = "ap-northeast-1"
}

# terraform code to spinup the ec2 instance

resource "aws_instance" "linux" {
  ami = "ami-02a2700d37baeef8b"
  tags = {
    Name = "Linux-Computer"
  }
  instance_type   = "t2.micro"
  key_name        = "terraform-linux"
  security_groups = ["${aws_security_group.allow_ssh.name}"]
}

# creating security group

resource "aws_security_group" "allow_ssh" {
  tags = {
    Name = "Allow_SSH"
  }
  name        = "allow_ssh"
  description = "allow ssh traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

