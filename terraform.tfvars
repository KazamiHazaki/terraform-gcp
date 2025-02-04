credentials_file        = "creds/credentials.json"
project_id              = "unique-hash-448408-d6"

# mysql
sql_instance_name       = "mysql-terraform"
sql_database_name       = "my-database-terraform"
sql_username            = "db-user"

# compute instance
vm_instance_name        = "vm-terraform"
region_vm = "us-central1-a"
vm_machine_type = "e2-micro"

# pubsub
topic_names = [
  "topic1",
  "topic2",
  "topic3"
]

subscription_names = [
  "topic1",
  "topic2",
  "topic3"
]


# registry
registry_name          = "my-name-terraform"
registry_location      = "asia-southeast2"


# gcs

bucket_names     = ["tf-test-config", "tf-test-asset", "tf-test-contact"]
bucket_location  = "US"
public_bucket_name = "tf-test-asset"
