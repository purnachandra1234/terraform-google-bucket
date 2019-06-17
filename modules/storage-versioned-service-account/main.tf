#------------------------------------------------------------------------------
# GOOGLE PROVIDER
#------------------------------------------------------------------------------

provider "google" {
  region  = var.region
  project = var.project_id
}

provider "google-beta" {
  region  = var.region
  project = var.project_id
}

#------------------------------------------------------------------------------
# BUCKET
#------------------------------------------------------------------------------

# Generate a random id for the bucket as it must have globally unique name
resource "random_id" "bucket_name" {
  prefix      = var.bucket_prefix
  byte_length = "8"
}

# Create the storage bucket
resource "google_storage_bucket" "bucket" {
  name     = random_id.bucket_name.hex
  project  = var.project_id
  location = var.location

  force_destroy = var.force_destroy

  storage_class = "MULTI_REGIONAL"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      num_newer_versions = var.versions_to_keep
    }
  }

  labels = var.custom_labels
}

#------------------------------------------------------------------------------
# GRANT ACCESS TO SERVICE ACCOUNT
#------------------------------------------------------------------------------

# Grant service account access to the storage bucket
resource "google_storage_bucket_iam_member" "app" {
  count  = length(var.storage_bucket_roles)
  bucket = google_storage_bucket.bucket.name
  role   = element(var.storage_bucket_roles, count.index)
  member = "serviceAccount:${var.service_account_email}"
}

