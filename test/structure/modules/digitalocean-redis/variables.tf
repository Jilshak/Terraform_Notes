variable "cluster_id" {
  description = "Description for digital ocean cluster id"
  type = string
}

variable "maxmemory_policy" {
  description = "This is the description for the max_memory policy"
  type = string
}

variable "notify_keyspace_events" {
  description = "This is the keyspace events"
  type = string
}

variable "timeout" {
  description = "This is the description for the timeout"
  type = number
}