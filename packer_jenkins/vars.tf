variable "AWS_REGION" {
  default = "us-west-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

variable "JENKINS_VERSION" {
  default = "2.204.5"
}

variable "TERRAFORM_VERSION" {
  default = "0.12.23"
}

variable "APP_INSTANCE_COUNT" {
  default = "0"
}

variable "DUMMY_SSH_PUB_KEY" {
  description = "public ssh key to put in place if there's no public key defined - to avoid errors in jenkins if it doesn't have a public key"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCj3wVNpsmkptht5vn0Kiaypxim93iV1zhwsXbm33nkS/I4kHHCJV30VTmeDQ0kHjs+9tDjsCWe7Ua4tUN2x/jc6B17nS/Bzi7PRaOX38oU8ltQxTLLaD7Gl6MEVa6bGjFRLRSr77ebqFkEjUgjCJNLhqkZo95tGy5hSfAyYURv7xvL8kRhfF5oMF/PgLPs0kD6FtbjMU4/ECZNUrdcpVObnIks433AUk6PFlWWiTy/0NSwy5gOBWBjxZ8w+0rzWAisRnfNHq7snz9NOpLco9Ln8q/Z2V4i/BFD9JrbqSUHmlV4XtGxjkWrSlKPQWef1inXRHniHe/GkGwJr/R/Ssob vagrant@ubuntu-bionic"
}
