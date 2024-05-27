
module "digitalocean_droplet" {
  source = "./digitalocean_droplet"
  image_value  = "ubuntu-20-04-x64"
  name_value   = "web-1"
  region_value = "nyc2"
  size_value   = "s-1vcpu-1gb"
}

module "digitalocean_database_redis_config" {
  source = "./digitalocean-redis"
  cluster_id = "testing"
  maxmemory_policy = "no idean"
  notify_keyspace_events = "anything here"
  timeout = 90
}

module "aws_s3_bucket" {
  source = "./aws_s3"
  bucket_name = "blue bucket"
  encoding_type = "sha"
  endpoint_type = "something here"
  endpoint_id = "92384793545lsdjfsl"
  service_access_role_arn = "3482hksdwr8dsa6fs"
}

output "root_output" {
  value = module.aws_s3_bucket.s3_bucket_name
}