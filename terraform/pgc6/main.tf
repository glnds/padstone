
module "playground" {
  source = "../module-playground"
  # CentOS images: https://wiki.centos.org/Cloud/AWS
  ami = "ami-edb9069e"
  subnet = "subnet-b1a86ac7"
  security_group = "sg-e3865f84"
  name = "pg_centos_6"
  stack = "Development"
  zone_id = "ZSQ8AQXTNONQX"
  eip_allocation_id = "eipalloc-c1a7f6a4"
  eip_ip = "52.18.242.155"
  dns_name = "pgc6"
}
