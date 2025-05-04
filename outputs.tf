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

output "dynamodb_table_name" {
  value       = one(aws_dynamodb_table.with_server_side_encryption[*].name)
  description = "DynamoDB table name"
}

output "dynamodb_table_id" {
  value       = one(aws_dynamodb_table.with_server_side_encryption[*].id)
  description = "DynamoDB table ID"
}

output "dynamodb_table_arn" {
  value       = one(aws_dynamodb_table.with_server_side_encryption[*].arn)
  description = "DynamoDB table ARN"
}