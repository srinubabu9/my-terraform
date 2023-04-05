provider "aws" {
  profile    = "terraform-user"
  access_key = "AKIAVXKEPQ5KEVVA6I7S"
  secret_key = "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"
  region     = "ap-northeast-1"
}

# terraform code tp spinup the ec2 instance

resource "aws_instance" "linux" {
  ami = "ami-0cd0830ef4d2de449"
  tags = {
    Name = "linux_servers"
  }

  instance_type   = "t2.micro"
  key_name        = "linux-multiple-instance"
  count           = 4
  security_groups = ["${aws_security_group.allow_ssh.name}"]
}


resource "aws_security_group" "allow_ssh" {
  tags = {
    Name = "Allow_SSH_HTTP"
  }
  name        = "allow_ssh"
  description = " allow ssh traffic"


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

