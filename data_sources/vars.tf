variable "AWS_REGION" {
  default = "us-west-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-west-1 = "ami-0e42deec9aa2c90ce"
    us-east-1 = "ami-07bfe0a3ec9dfcffa"
  }
}

