resource "aws_key_pair" "bastion_key" {
  key_name = "${var.project_name}-key"
  public_key = file("~/.ssh/id_rsa.pub")
  tags = var.tags
}