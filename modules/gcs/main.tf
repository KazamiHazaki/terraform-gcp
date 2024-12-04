# Create GCS Buckets
resource "google_storage_bucket" "buckets" {
  for_each      = toset(var.bucket_names)
  name          = each.value
  location      = var.bucket_location
  storage_class = "STANDARD"
  force_destroy = true
  versioning {
    enabled = false
  }

}

# Configure Public Access for the Public Bucket

resource "google_storage_bucket_iam_binding" "binding" {
  for_each = toset([var.public_bucket_name])

  bucket = google_storage_bucket.buckets[each.value].name
  role = "roles/storage.legacyObjectReader"
  members = ["allUsers",]
}

output "gcs_names" {
  value = [for bucket in google_storage_bucket.buckets : bucket.name]
  description = "List of GCS bucket names"
}
