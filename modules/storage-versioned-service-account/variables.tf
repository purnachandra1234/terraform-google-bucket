# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
# ---------------------------------------------------------------------------------------------------------------------
variable "project_id" {
  description = "GCP project ID"
}

variable "bucket_prefix" {
  description = "Bucket name must be globally unique so this prefix will be suffixed with random string"
}

variable "location" {
  description = "The location of the bucket (US/EU/ASIA)"
}

variable "service_account_email" {
  description = <<EOF
  Service account of the application that needs to be linked to the bucket storage.
EOF
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------
variable "storage_bucket_roles" {
  type = list(string)

  default = [
    "roles/storage.legacyBucketReader",
    "roles/storage.objectAdmin",
  ]
}

variable "force_destroy" {
  description = <<EOF
If set to true, this will force the delete of the bucket 
when you run terraform destroy,
even if there is still content in it. 
This is only meant for testing and should not be used in production.
EOF

  type    = bool
  default = false
}

variable "versions_to_keep" {
  description = <<EOF
The number of version to keep before permanently deleting the object.
Usually `1` is safe. The more versions it keeps, the more storage is used.
EOF
default = 1
}


variable "custom_labels" {
description = "A map of custom labels to apply to the resources. The key is the label name and the value is the label value."
type = map(string)
default = {}
}

