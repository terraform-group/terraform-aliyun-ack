resource "alicloud_vpc" "vpc" {
  vpc_name   = "k8s_vpc"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "172.16.0.0/16"
  zone_id    = "cn-zhangjiakou-a"
}