locals {
  cluster_version = "1.20.11-aliyun.1"
  service_cidr    = "192.168.0.0/16"
  pod_cidr        = "10.81.0.0/16"
}

resource "alicloud_cs_managed_kubernetes" "k8s" {
  name                  = var.cluster_name
  version               = local.cluster_version
  cluster_spec          = "ack.standard"
  availability_zone     = "cn-zhangjiakou-a"
  service_cidr          = local.service_cidr
  pod_cidr              = local.pod_cidr
  new_nat_gateway       = true
  load_balancer_spec    = "slb.s1.small"
  slb_internet_enabled  = true
  password              = "Password123.com"
  node_port_range       = "30000-32767"
  os_type               = "Linux"
  platform              = "CentOS"
  worker_number         = 1
  worker_instance_types = ["ecs.g6.xlarge"]
  worker_vswitch_ids    = [alicloud_vswitch.vsw.id]
  worker_disk_category  = "cloud_efficiency"
  worker_disk_size      = 40

  dynamic "addons" {
    for_each = var.cluster_addons
    content {
      name   = lookup(addons.value, "name", var.cluster_addons)
      config = lookup(addons.value, "config", var.cluster_addons)
    }
  }
  runtime = {
    name    = "docker"
    version = "19.03.5"
  }
}