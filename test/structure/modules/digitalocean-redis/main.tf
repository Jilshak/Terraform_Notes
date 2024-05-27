terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_database_redis_config" "digitalocean_redis" {
  cluster_id = var.cluster_id
  maxmemory_policy = var.maxmemory_policy
  notify_keyspace_events = var.notify_keyspace_events
  timeout = var.timeout
}