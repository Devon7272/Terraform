variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-west-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0c43b23f011ba5061"
    us-west-1 = "ami-0345db60aa8e3fa3d"
  }
}

