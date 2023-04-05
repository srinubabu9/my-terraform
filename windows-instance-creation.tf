# this is provider information
provider"aws" {
  profile    = "terraform-user"
  access_key = "AKIAVXKEPQ5KEVVA6I7S"
  secret_key = "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"
  region     = "ap-northeast-1"
}

resource "aws_instance" "windows" {
  ami = "ami-0b168f9cd578fe5d5"
  tags = {
    Name = "windows_computer"
  }
  instance_type   = "t2.micro"
  key_name        = "terraform-windows"
  security_groups = ["${aws_security_group.allow_rdp.name}"]
}

resource "aws_security_group" "allow_rdp" {
  tags = {
    name = "Allow_RDP"
  }
  name        = "allow_rdp"
  description = " allow rdp traffic "

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

