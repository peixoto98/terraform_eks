resource "aws_security_group" "bastion_sg" {
  name        = "Bastion SSH security group"
  description = "Allow SSH outbound traffic"
  vpc_id      = var.vpc

  ingress {
    description      = "SSH from all"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  associate_public_ip_address = true
  tags = merge(
    var.tags,
    { Name = "bastion" }
  )
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  subnet_id                   = var.public_subnet
  key_name                    = aws_key_pair.bastion_key.key_name

  user_data = <<EOF
#!/bin/bash

apt-get update -y
apt-get install ansible -y

EOF
}