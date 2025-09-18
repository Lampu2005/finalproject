provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_eks_cluster" "eks" {
  name     = "eks-demo"
  role_arn = "arn:aws:iam::<ACCOUNT_ID>:role/EKSClusterRole"

  vpc_config {
    subnet_ids = ["subnet-123456", "subnet-abcdef"] # da adattare
  }
}
