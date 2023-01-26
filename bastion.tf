resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amzlinux2.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_a.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.bastion_sg.id]
  key_name                    = data.aws_key_pair.sandbox.key_name
  tags = merge(
    var.common_tags,
    {
      Name = "Bastion-host"
    }
  )
}