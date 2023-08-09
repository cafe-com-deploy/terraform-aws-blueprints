resource "aws_cloudwatch_log_group" "default" {
  name              = "/ecs/${var.name}"
  retention_in_days = var.retention_in_days
  tags              = var.tags
}
