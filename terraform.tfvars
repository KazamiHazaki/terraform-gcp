# main var
credentials_file        = "creds/credentials.json"
project_id              = "unique-hash-448408-d6"

# mysql
sql_instance_name       = "rbm-sql-dev"
sql_database_name       = "rbm-dev"
sql_username            = "rbm-dev-local"

# compute instance
vm_instance_name        = "worker"
region_vm = "us-central1-a"
vm_machine_type = "e2-micro"

# pubsub
topic_names = [
  "import-contact-group",
  "publisher",
  "worker",
  "viewer-detail-campaign"
]

subscription_names = [
  "import-contact-group",
  "publisher",
  "worker",
  "viewer-detail-campaign"
]


# registry
registry_name          = "rbm-main"
registry_location      = "asia-southeast2"


# gcs

bucket_names     = ["sinergidev-assets", "sinergidev-config", "sinergidev-contact"]
bucket_location  = "US"
public_bucket_name = "sinergidev-assets"
