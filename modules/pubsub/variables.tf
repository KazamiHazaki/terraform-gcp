variable "topic_names" {
  type        = list(string)
  description = "List of Pub/Sub topic names"
}

variable "subscription_names" {
  type        = list(string)
  description = "List of subscription names"
}
