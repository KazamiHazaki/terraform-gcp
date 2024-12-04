provider "google" {
  credentials = file(var.credentials_file) # Path to GCP credentials JSON file
  project     = var.project_id
  region      = var.region
}

# GCS Buckets
module "gcs" {
  source = "./modules/gcs"
  bucket_names = var.bucket_names
  bucket_location    = var.bucket_location
  public_bucket_name = var.public_bucket_name
}

# Cloud SQL (MySQL)
module "cloud_sql" {
  source        = "./modules/cloud_sql"
  project_id = var.project_id
  instance_name = var.sql_instance_name
  region        = var.region
  database_name = var.sql_database_name
  sql_username     = var.sql_username
}

# Compute VM Instance
module "compute_instance" {
  source        = "./modules/compute_instances"
  instance_name = var.vm_instance_name
  region_vm        = var.region_vm
  machine_type  = var.vm_machine_type
}

# Pub/Sub Topic and Subscription
module "pubsub" {
  source = "./modules/pubsub"
  topic_names      = var.topic_names
  subscription_names = var.subscription_names
}

# Docker Registry (Artifact Registry)
module "artifact_registry" {
  source = "./modules/artifact_registry"
  registry_location = var.registry_location 
  registry_name = var.registry_name
}

output "gcs_bucket_names" {
  value = module.gcs.gcs_names
}

output "sql_instance_connection_name" {
  value = module.cloud_sql.connection_name
}

output "sql_db_password" {
  value = module.cloud_sql.sql_db_password
  description = "The randomly generated database password"
  sensitive   = true
}

output "vm_instance_external_ip" {
  value = module.compute_instance.external_ip
}

output "pubsub_topic" {
  value = module.pubsub.pubsub_topic_name
}
