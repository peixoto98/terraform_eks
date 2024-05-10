resource "aws_security_group" "allow_mongodb" {
  name   = "MongoDB access from EKS node group"
  vpc_id = var.vpc

  ingress {
    description = "MongoDB from EKS cluster sg"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    security_groups = [
      var.cluster_sg
    ]
  }

  ingress {
    description = "SSH from bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [
      aws_security_group.bastion_sg.id
    ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  tags = merge(
    var.tags,
    { Name = "mongodb" }
  )
  vpc_security_group_ids = [
    aws_security_group.allow_mongodb.id
  ]
  subnet_id = var.private_subnet
  key_name  = aws_key_pair.bastion_key.key_name
}