terraform {
  backend "s3"{
    bucket = "tf-test-f3c45"
    key    = "terraform/demo4"
    region = "us-west-1"
  }
}
