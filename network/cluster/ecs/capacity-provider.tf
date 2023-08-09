resource "aws_ecs_cluster_capacity_providers" "default" {
  cluster_name = aws_ecs_cluster.default.name

  capacity_providers = var.capacity_providers
}
