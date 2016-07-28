
module "playground" {
  source = "../module-playground"
  # CentOS images: https://wiki.centos.org/Cloud/AWS
  ami = "ami-7abd0209"
  subnet = "subnet-b1a86ac7"
  security_group = "sg-e3865f84"
  name = "pg_centos_7"
  stack = "Development"
  zone_id = "ZSQ8AQXTNONQX"
  eip_allocation_id = "eipalloc-241a4a41"
  eip_ip = "52.208.220.37"
  dns_name = "pgc7"
}
