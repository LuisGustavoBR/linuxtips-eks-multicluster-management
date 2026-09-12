provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kubernetes" {
  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.default.token
}


provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.default.token
  }
}

provider "kubectl" {
  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.default.token
}
