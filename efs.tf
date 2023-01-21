resource "aws_efs_file_system" "wp-efs" {
   creation_token = "wp-efs"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
 tags = merge(
    var.common_tags,
    {
      Name = "wp-efs"
    }
  )
 }

 resource "aws_efs_mount_target" "efs-mt-a" {
   file_system_id  = aws_efs_file_system.wp-efs.id
   subnet_id = aws_subnet.application_subnet_a.id
   security_groups = [aws_security_group.wp_efs_sg.id]
 }

 resource "aws_efs_mount_target" "efs-mt-b" {
   file_system_id  = aws_efs_file_system.wp-efs.id
   subnet_id = aws_subnet.application_subnet_b.id
   security_groups = [aws_security_group.wp_efs_sg.id]
 }