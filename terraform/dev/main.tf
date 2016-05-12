
module "playground" {
  source = "../module-playground"

  subnet = "subnet-b1a86ac7"
  security_group = "sg-e3865f84"
  name = "dplayground"
  stack = "Development"
  zone_id = "ZSQ8AQXTNONQX"
}
