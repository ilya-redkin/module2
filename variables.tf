variable "aws_region" {
    description = "An AWS Regions where resources are created"
    type = string
    default = "us-east-1"
}

variable "common_tags" {
    description = "Common tags"
    type = map(string)
    default = {
      "Project" = "Wordpress-workshop"
      "Created_with" = "Terraform"
    }
}