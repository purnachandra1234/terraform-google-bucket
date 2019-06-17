output "bucket_link" {
  value = google_storage_bucket.bucket.self_link
}

output "bucket_name" {
  value = google_storage_bucket.bucket.name
}

output "bucket_url" {
  value = format("storage.googleapis.com/%s", google_storage_bucket.bucket.name)
}
