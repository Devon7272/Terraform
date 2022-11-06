data "aws_availability_zones" "available" {}

# define ami
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

# define autoacaling launch configuration
resource "aws_launch_configuration" "demo-lc" {
  name            = "demo-lc"
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.demokey.id
  security_groups = [aws_security_group.demo-instance-sg.id]
  user_data       = "${file("user_data.sh")}"
}

# define autoscaling group 
resource "aws_autoscaling_group" "demo-asg" {
  name                      = "demo-asg"
  #todo: refernce subnets
  vpc_zone_identifier       = [aws_subnet.demovpc-public-1.id, aws_subnet.demovpc-public-2.id]
  launch_configuration      = aws_launch_configuration.demo-lc.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  load_balancers = [aws_elb.demo-elb.name]
  

  tag {
    key                 = "Name"
    value               = "demo_ec2_instance"
    propagate_at_launch = true
  }
}

# define autoscaling policy
resource "aws_autoscaling_policy" "demo-cpu-policy" {
  name                   = "demo-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.demo-asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
  policy_type            = "SimpleScaling"
}

# define cloudwatch monitoring 
resource "aws_cloudwatch_metric_alarm" "demo-cpu-alarm" {
  alarm_name          = "demo-cpu-alarm"
  alarm_description   = "alarm when cpu increases"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 20

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.demo-asg.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.demo-cpu-policy.arn]
}

# define auto descaling policy 
resource "aws_autoscaling_policy" "demo-cpu-policy-scaledown" {
  name                   = "demo-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.demo-asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
  policy_type            = "SimpleScaling"
}

# define descaling cloud watch 
resource "aws_cloudwatch_metric_alarm" "demo-cpu-alarm-scaledown" {
  alarm_name          = "demo-cpu-alarm"
  alarm_description   = "alarm when cpu decreases"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 20

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.demo-asg.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.demo-cpu-policy.arn]
}

output "elb" {
  value = aws_elb.demo-elb.dns_name
}