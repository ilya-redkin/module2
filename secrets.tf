resource "aws_ssm_parameter" "db_password" {
  name  = "/module_2/rds_password"
  type  = "SecureString"
  value = "qwertyui"
}