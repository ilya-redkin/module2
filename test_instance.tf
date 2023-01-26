resource "aws_instance" "test_instance" {
  ami                         = data.aws_ami.amzlinux2.id
  instance_type               = "t2.small"
  subnet_id                   = aws_subnet.application_subnet_a.id
  associate_public_ip_address = false
  security_groups = [aws_security_group.bastion_sg_inbound.id, aws_security_group.wp_db_client_sg.id, aws_security_group.wp_efs_client_sg.id,
  aws_security_group.alb_sg.id]
  key_name = data.aws_key_pair.sandbox.key_name
  tags = merge(
    var.common_tags,
    {
      Name = "test_instance"
    }
  )
}