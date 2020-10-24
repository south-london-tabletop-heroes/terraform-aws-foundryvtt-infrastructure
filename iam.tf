data "aws_iam_policy_document" "foundryvtt_infrastructure_assume_from_ecs_tasks" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "foundryvtt_infrastructure_ecs_task_access_s3" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:DeleteObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      aws_s3_bucket.foundryvtt_infrastructure_s3_state.arn,
      format("%s/*", aws_s3_bucket.foundryvtt_infrastructure_s3_state.arn),
      aws_s3_bucket.foundryvtt_infrastructure_s3_media.arn,
      format("%s/*", aws_s3_bucket.foundryvtt_infrastructure_s3_media.arn)
    ]
  }
  statement {
    actions = [
      "s3:ListAllMyBuckets"
    ]
    resources = [
      aws_s3_bucket.foundryvtt_infrastructure_s3_state.arn,
      aws_s3_bucket.foundryvtt_infrastructure_s3_media.arn
    ]
  }
}

resource "aws_iam_role" "foundryvtt_infrastructure_ecs_task" {
  name               = format("foundryvtt-infrastructure-%s-ecs-task", var.name)
  assume_role_policy = data.aws_iam_policy_document.foundryvtt_infrastructure_assume_from_ecs_tasks.json
}

resource "aws_iam_policy" "foundryvtt_infrastructure_ecs_task_access_s3" {
  name   = format("foundryvtt-infrastructure-%s-ecs-task-access-s3", var.name)
  policy = data.aws_iam_policy_document.foundryvtt_infrastructure_ecs_task_access_s3.json
}

resource "aws_iam_role_policy_attachment" "foundryvtt_infrastructure_ecs_task_access_s3" {
  role       = aws_iam_role.foundryvtt_infrastructure_ecs_task.id
  policy_arn = aws_iam_policy.foundryvtt_infrastructure_ecs_task_access_s3.arn
}
