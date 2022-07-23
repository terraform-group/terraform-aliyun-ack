resource "alicloud_vpc" "vpc" {
  vpc_name   = "k8s_vpc"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "172.16.0.0/16"
  zone_id    = "cn-zhangjiakou-c"
}

resource "alicloud_cs_serverless_kubernetes" "main" {
  cluster_spec                   = "ack.standard"
  deletion_protection            = false
  load_balancer_spec             = "slb.s2.small"
  logging_type                   = "SLS"
  name                           = "k8s"
  tags                           = {}
  version                        = "1.22.10-aliyun.1"
  vpc_id                         = alicloud_vpc.vpc.id
  vswitch_ids                    = [alicloud_vswitch.vsw.id]
  new_nat_gateway                = true
  endpoint_public_access_enabled = true
  time_zone                      = "Asia/Shanghai"
  service_cidr                   = "192.168.0.0/16"
  service_discovery_types        = ["CoreDNS"]


  timeouts {}
  addons {
    # SLB Ingress
    name = "alb-ingress-controller"
    config = "{\"IngressSlbNetworkType\":\"internet\",\"IngressSlbSpec\":\"slb.s2.small\"}"
  }
  addons {
    name = "metrics-server"
  }
  #   addons {
  #     name = "knative"
  #   }
}
