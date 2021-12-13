# AUTOSCALING GROUP STEPS 
# PLACEMENT GROUP(aws_placement_group)

resource "aws_placement_group" "thelma-plg1" {
  name     = "thelma-plg"
  strategy = "cluster"
}

# launch_configuration

resource "aws_launch_configuration" "thelma-ltp" {
  name_prefix   = "Launch_Template"
  image_id      = "ami-0d37e07bd4ff37148"
  instance_type = "t2.micro"

 # key_name = "EC2 PRACTICE"

  lifecycle {
      create_before_destroy = true
  }
}

# aws_autoscaling_group

resource "aws_autoscaling_group" "thelma-auto" {
  name                      = "myt-asg"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  placement_group           = aws_placement_group.thelma-plg1.id
  launch_configuration      = aws_launch_configuration.thelma-ltp.name
  vpc_zone_identifier       = [aws_subnet.thelma-PUB1-SUB1.id, aws_subnet.thelma-PUB2-SUB2.id]
  target_group_arns         = [aws_alb_target_group.thelma_alb_target_group.arn]

  lifecycle {
      create_before_destroy = true
  }

  tag {
    key                 = "name"
    value               = "myt-asg"
    propagate_at_launch = true
  }

}