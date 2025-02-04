# Reserve an internal IP range for Private Service Access (PSA)
resource "google_compute_global_address" "private_ip_alloc" {
  name          = "private-ip-allocation"
  project       = var.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "projects/${var.project_id}/global/networks/default"
}

# Create a VPC peering connection for Private Service Access
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = "projects/${var.project_id}/global/networks/default"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

resource "google_sql_database_instance" "mysql" {
  name             = var.instance_name
  database_version = "MYSQL_8_0"
  region           = var.region
  project          = var.project_id
  settings {
    tier               = "db-custom-2-8192" # 2 vCPU, 8 GB RAM
    disk_size          = 10                 # 10 GB storage
    disk_autoresize    = true               # Automatic storage increase
    availability_type = "ZONAL"
    maintenance_window {
      day          = 7    # Sunday
      hour         = 18   # 1:00 AM Jakarta (GMT+7) is 18:00 UTC
      update_track = "stable"
    }
    ip_configuration {
      ipv4_enabled    = true
      private_network = "projects/${var.project_id}/global/networks/default"
    }
    password_validation_policy {
      enable_password_policy       = true
    }  

    backup_configuration {
      enabled = true
      binary_log_enabled = true
      start_time = "18:00"
      transaction_log_retention_days = 7
      backup_retention_settings {
        retained_backups = 7
      }
    }

    deletion_protection_enabled = true # Enables deletion protection of an instance at the GCP level
    
  } 
  deletion_protection = true # Whether Terraform will be prevented from destroying the instance
}

resource "google_sql_database" "default" {
  name     = var.database_name
  instance = google_sql_database_instance.mysql.name
}

resource "google_sql_user" "custom_user" {
  name               = var.sql_username
  project            = google_sql_database_instance.mysql.project
  instance           = google_sql_database_instance.mysql.name
  password           = random_password.db_password.result
  host               = "%"
  password_policy {
    allowed_failed_attempts = 7
    enable_failed_attempts_check = true

  }
}

resource "random_password" "db_password" {
  length  = 16
  special = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

output "connection_name" {
  value = google_sql_database_instance.mysql.name 
}

output "sql_db_password" {
  value = random_password.db_password.result 
  description = "The randomly generated database password"
  sensitive   = true
}