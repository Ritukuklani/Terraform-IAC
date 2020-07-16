provider "aws" {
  region = "us-east-2"
}

#The count parameter should be hard-coded and cannot depend on the outputs of other resources.
#In other words count should be known during terraform plan
//resource "aws_instance" "example_2" {
//  count             = length(data.aws_availability_zones.all.names)
//  availability_zone =
//    data.aws_availability_zones.all.names[count.index]
//  ami               = "ami-0c55b159cbfafe1f0"
//  instance_type     = "t2.micro"
//}
//data "aws_availability_zones" "all" {}

//resource "aws_iam_user" "example" {
//  name = "neo"
//}

#Will create three IAM Users with names neo.1, neo.2, neo.3
//resource "aws_iam_user" "example" {
//  count = 3
//  name  = "neo.${count.index}"
//}

#Will create three iam users with names Neo, Trinity and Morpheus
//resource "aws_iam_user" "example" {
//  count = length(var.user_names)
//  name  = var.user_names[count.index]
//}

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name     = each.value
}

//resource "aws_autoscaling_group" "example" {
//  launch_configuration = aws_launch_configuration.example.name
//  vpc_zone_identifier  = data.aws_subnet_ids.default.ids
//  target_group_arns    = [aws_lb_target_group.asg.arn]
//  health_check_type    = "ELB"
//  dynamic "tag" {
//    for_each = var.custom_tags
//    content {
//      key                 = tag.key
//      value               = tag.value
//      propagate_at_launch = true
//    }
//  }
//}

resource "aws_iam_policy" "cloudwatch_read_only" {
  name   = "cloudwatch-read-only"
  policy = data.aws_iam_policy_document.cloudwatch_read_only.json
}
data "aws_iam_policy_document" "cloudwatch_read_only" {
  statement {
    effect    = "Allow"
    actions   = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudwatch_full_access" {
  name   = "cloudwatch-full-access"
  policy = data.aws_iam_policy_document.cloudwatch_full_access.json
}
data "aws_iam_policy_document" "cloudwatch_full_access" {
  statement {
    effect    = "Allow"
    actions   = ["cloudwatch:*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy_attachment" "neo_cloudwatch_full" {
  count = var.give_neo_cloudwatch_full_access ? 1 : 0
  user       = aws_iam_user.example[0].name
  policy_arn = aws_iam_policy.cloudwatch_full_access.arn
}
resource "aws_iam_user_policy_attachment" "neo_cloudwatch_read" {
  count = var.give_neo_cloudwatch_full_access ? 0 : 1
  user       = aws_iam_user.example[0].name
  policy_arn = aws_iam_policy.cloudwatch_read_only.arn
}

