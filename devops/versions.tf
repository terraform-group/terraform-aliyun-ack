terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.12.1"
    }
    alicloud = {
      source  = "aliyun/alicloud"
      version = "1.177.0"
    }
  }
}

provider "kubernetes" {
  # Configuration options
}