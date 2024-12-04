resource "google_pubsub_topic" "topic" {
  for_each = toset(var.topic_names)  # Iterate over the list of topic names
  name     = each.value
}

resource "google_pubsub_subscription" "subscription" {
  for_each = toset(var.subscription_names)  # Iterate over the list of subscription names
  name     = "${google_pubsub_topic.topic[each.key].name}-sub"  # Subscription ID based on topic name
  topic    = google_pubsub_topic.topic[each.key].name  # Link the subscription to the corresponding topic

  # Default configurations
  ack_deadline_seconds        = 10  # Acknowledge deadline of 10 seconds
  message_retention_duration  = "604800s"  # 7 days message retention duration (604800 seconds)
  expiration_policy {
    ttl = "2678400s"  # 31 days inactivity expiration policy (2678400 seconds)
  }
  push_config {
    push_endpoint = ""  # Empty push endpoint for pull delivery type
  }
  retry_policy {
    minimum_backoff = "10s"  # Immediate retry policy with 10 seconds minimum backoff
    maximum_backoff = "60s"  # 60 seconds max retry backoff (optional)
  }
}


output "pubsub_topic_name" {
  value = [for topic in google_pubsub_topic.topic : topic.name]
  description = "List of Pub/Sub topic names"
}
