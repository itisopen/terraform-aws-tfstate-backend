output "terraform_backend_config" {
  description = "Rendered Terraform backend config file."
  value       = local.enabled ? local.terraform_backend_config_content : ""
}

output "bucket_name" {
  description = "The name of the OCI Object Storage bucket."
  value       = oci_objectstorage_bucket.default[0].name
}

output "bucket_namespace" {
  description = "The namespace of the OCI Object Storage bucket."
  value       = oci_objectstorage_bucket.default[0].namespace
}

output "bucket_compartment_id" {
  description = "The compartment ID of the OCI Object Storage bucket."
  value       = oci_objectstorage_bucket.default[0].compartment_id
}

output "nosql_table_name" {
  description = "The name of the OCI NoSQL table."
  value       = oci_nosql_table.default[0].name
}

output "nosql_table_compartment_id" {
  description = "The compartment ID of the OCI NoSQL table."
  value       = oci_nosql_table.default[0].compartment_id
}
