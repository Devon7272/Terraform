resource "aws_key_pair" "demokey" {
  key_name   = "demo-auth"
  public_key = file("~/.ssh/id_demokey.pub")
}