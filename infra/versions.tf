terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "1.177.0"
    }
  }
}

provider "alicloud" {
  # Configuration options
  region = "cn-zhangjiakou"
}