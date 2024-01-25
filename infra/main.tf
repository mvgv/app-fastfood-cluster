provider "aws" {
  region = "us-east-1"
}

module "eks" {
  source        = "terraform-aws-modules/eks/aws"
  version       = "19.0.0"
  cluster_name  = "appfastfood-cluster-teste"
  cluster_version = "1.28"
  cluster_endpoint_private_access = false
  cluster_endpoint_public_access = true
  create_kms_key = false

  vpc_id     = "vpc-05ba31270003da29b"
  subnet_ids = [
    "subnet-03f7aa4b4780b89ad",  # my-vpc-private-us-east-1a
    "subnet-02c982c370c77fd11",  # my-vpc-public-us-east-1a
    "subnet-0f938a5d312e5c832",  # my-vpc-public-us-east-1b
    "subnet-0cec6e18625316d62",  # my-vpc-private-us-east-1b
  ]

  cluster_encryption_config = {}

  eks_managed_node_groups = {
    alura = {
      min_size                = 1
      max_size                = 10
      desired_size            = 3
      vpc_security_group_ids = ["sg-0ffe261cc2058834c"]
      instance_types          = ["t2.micro"]
    }
  }
}