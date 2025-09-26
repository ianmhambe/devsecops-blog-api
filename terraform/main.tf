provider "aws" {
  region = "eu-north-1"
}

resource "aws_ecs_cluster" "blog_api_cluster" {
  name = "blog-api-cluster"
}

resource "aws_ecs_task_definition" "blog_api_task" {
  family                   = "blog-api-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = jsonencode([
    {
      name  = "blog-api",
      image = "197493246079.dkr.ecr.eu-north-1.amazonaws.com/blog-api:latest",
      essential = true,
      portMappings = [
        {
          containerPort = 3000,
          hostPort      = 3000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "blog_api_service" {
  name            = "blog-api-service"
  cluster         = aws_ecs_cluster.blog_api_cluster.id
  task_definition = aws_ecs_task_definition.blog_api_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = ["subnet-0e3f43c08796594ae", "subnet-034c6aca81e6699db"]
    security_groups  = ["sg-024502ea1a6e7157a"]
    assign_public_ip = true
  }
}
