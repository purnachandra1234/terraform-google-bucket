variable "region" {
  type    = string
  default = "europe-west1"
}

variable "project_id" {
}

variable "bucket_prefix" {
  default = "my-app"
}

variable "location" {
  default = "EU"
}

variable "force_destroy" {
  description = <<EOF
If set to true, this will force the delete of the bucket 
when you run terraform destroy,
even if there is still content in it. 
This is only meant for testing and should not be used in production.
EOF

  type = bool
  default = false
}

variable "versions_to_keep" {
  description = <<EOF
The number of version to keep before permanently deleting the object.
Usually `1` is safe. The more versions it keeps, the more storage is used.
EOF
default = 1
}

variable "storage_bucket_roles" {
type = list(string)

default = [
"roles/storage.legacyBucketReader",
"roles/storage.objectAdmin",
]
}

variable "service_account_email" {
description = <<EOF
  Service account of the application that needs to be linked to the bucket storage.
EOF

}

variable "custom_labels" {
description = "A map of custom labels to apply to the resources. The key is the label name and the value is the label value."
type = map(string)
default = {}
}

