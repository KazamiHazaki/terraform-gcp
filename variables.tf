variable "credentials_file" {
  type = string
}

variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "region_vm" {
  type    = string
}
# GCS

variable "bucket_names" {
  type = list(string)
}

variable "bucket_location" {
  type    = string
}

variable "public_bucket_name" {
  type = string
}


# SQL


variable "sql_instance_name" {
  type = string
}

variable "sql_database_name" {
  type = string
}

variable "sql_username" {
  type = string
}

variable "sql_password" {
  type = string
}

# VM Instance
variable "vm_instance_name" {
  type = string
}

variable "vm_machine_type" {
  type = string
}

# Pubsub

variable "topic_names" {
  type        = list(string)
  description = "List of Pub/Sub topic names"
}

variable "subscription_names" {
  type        = list(string)
  description = "List of subscription names"
}

# Registry

variable "registry_name" {
  type = string
}

variable "registry_location" {
  type = string
}


