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
