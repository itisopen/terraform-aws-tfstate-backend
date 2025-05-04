variable "terraform_backend_config_file_name" {
  type        = string
  description = "Name of the Terraform backend config file to generate."
  default     = "terraform.tf"
}

variable "terraform_backend_config_file_path" {
  type        = string
  description = "Directory for the Terraform backend config file."
  default     = ""
}

variable "terraform_backend_config_template_file" {
  type        = string
  description = "The path to the template used to generate the config file."
  default     = ""
}

variable "terraform_version" {
  type        = string
  description = "The minimum required Terraform version."
  default     = "1.0.0"
}

variable "terraform_state_file" {
  type        = string
  description = "The path to the state file inside the bucket."
  default     = "terraform.tfstate"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name. If not provided, the name will be generated from the context by the label module."
  default     = ""

  validation {
    condition     = length(var.s3_bucket_name) < 64
    error_message = "A provided S3 bucket name must be fewer than 64 characters."
  }
}

variable "ddl_statement" {
  type        = string
  description = "(Required) (Updatable) Complete CREATE TABLE DDL statement. When update ddl_statement, it should be ALTER TABLE DDL statement."
  default     = "CREATE TABLE IF NOT EXISTS dev (id STRING, data JSON, PRIMARY KEY (id))"
}

variable "logging" {
  type = list(object({
    target_bucket = string
    target_prefix = string
  }))
  description = "Destination (S3 bucket name and prefix) for S3 Server Access Logs for the S3 bucket."
  default     = []
  validation {
    condition     = length(var.logging) < 2
    error_message = "Only 1 bucket logging configuration can be provided."
  }
}

variable "bucket_enabled" {
  type        = bool
  description = "Whether to create the OCI Object Storage bucket."
  default     = true
}


variable "kms_master_key_id" {
  type        = string
  default     = null
  description = <<-EOT
    (Optional) (Updatable) The OCID of a master encryption key used 
    to call the Key Management service to generate a data encryption 
    key or to encrypt or decrypt a data encryption key.
    EOT
}

variable "storage_tier" {
  type        = string
  description = "The storage tier of the bucket. Valid values are 'Standard', 'InfrequentAccess', or 'Archive'."
  default     = "Standard"
}

variable "public_access_type" {
  type        = string
  description = "The type of public access for the bucket. Valid values are 'NoPublicAccess', 'ObjectRead', or 'ObjectReadWithoutList'."
  default     = "NoPublicAccess"
}

variable "versioning" {
  type        = string
  description = "The versioning status of the bucket. Valid values are 'Enabled' or 'Suspended'."
  default     = "Enabled"
}

variable "policy_statements" {
  type        = list(string)
  description = "List of policy statements to apply to the bucket."
  default     = []
}

variable "is_auto_reclaimable" {
  type        = bool
  description = " (Optional) True if table can be reclaimed after an idle period."
  default     = false
}

variable "capacity_mode" {
  type        = string
  description = "Optional) (Updatable) The capacity mode of the table. If capacityMode = ON_DEMAND, maxReadUnits and maxWriteUnits are not used, and both will have the value of zero."
  default     = "ON_DEMAND"
}

variable "dynamodb_enabled" {
  type        = bool
  default     = true
  description = "Whether to create the DynamoDB table."
}

variable "dynamodb_table_name" {
  type        = string
  default     = null
  description = "Override the name of the DynamoDB table which defaults to using `module.dynamodb_table_label.id`"
}

variable "billing_mode" {
  type        = string
  description = "DynamoDB billing mode"
  default     = "PAY_PER_REQUEST"
}

variable "read_capacity" {
  type        = number
  description = "DynamoDB read capacity units when using provisioned mode"
  default     = 5
}

variable "write_capacity" {
  type        = number
  description = "DynamoDB write capacity units when using provisioned mode"
  default     = 5
}

variable "deletion_protection_enabled" {
  type        = bool
  description = "A boolean that enables deletion protection for DynamoDB table"
  default     = false
}

variable "enable_point_in_time_recovery" {
  type        = bool
  description = "Enable DynamoDB point-in-time recovery"
  default     = true
}

variable "oci_namespace" {
  description = "The name of the OCI namespace"
  type        = string
  default     = ""
}

variable "oci_tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
}

variable "oci_user_ocid" {
  description = "The OCID of the user"
  type        = string
}

variable "oci_fingerprint" {
  description = "The fingerprint for the API key"
  type        = string
}

variable "oci_private_key_path" {
  description = "The path to the private key file"
  type        = string
}

variable "oci_region" {
  description = "The OCI region to deploy resources in"
  type        = string
  default     = "eu-paris-1"
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-3"
}

variable "aws_profile" {
  type        = string
  default     = ""
  description = "AWS profile name as set in the shared credentials file"
}

variable "aws_role_arn" {
  type        = string
  default     = ""
  description = "The AWS role to be assumed"
}

variable "oci_compartment_id" {
  description = "The OCID of the compartment"
  type        = string
}

variable "access_type" {
  type        = string
  description = "(Optional) (Updatable) The type of public access enabled on this bucket. A bucket is set to NoPublicAccess by default, which only allows an authenticated caller to access the bucket and its contents. When ObjectRead is enabled on the bucket, public access is allowed for the GetObject, HeadObject, and ListObjects operations. When ObjectReadWithoutList is enabled on the bucket, public access is allowed for the GetObject and HeadObject operations."
  default     = "NoPublicAccess"
}

variable "auto_tiering" {
  type        = string
  description = "(Optional) (Updatable) Set the auto tiering status on the bucket. By default, a bucket is created with auto tiering Disabled. Use this option to enable auto tiering during bucket creation. Objects in a bucket with auto tiering set to InfrequentAccess are transitioned automatically between the 'Standard' and 'InfrequentAccess' tiers based on the access pattern of the objects."
  default     = "Disabled"
}

variable "defined_tags" {
  type        = map(string)
  description = "(Optioregionnal) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'}"
  default     = {}
}

variable "freeform_tags" {
  type        = map(string)
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'}"
  default     = {}  
}

variable "metadata" {
  type        = map(string)
  description = "(Optional) (Updatable) Arbitrary string, up to 4KB, of keys and values for user-defined metadata."
  default     = {}
}

variable "object_events_enabled" {
  type        = bool
  description = "(Optional) (Updatable) Whether or not events are emitted for object state changes in this bucket. By default, objectEventsEnabled is set to false. Set objectEventsEnabled to true to emit events for object state changes. For more information about events, see Overview of Events."
  default     = false
}

variable "retention_rule_display_name" {
  type        = string
  description = "(Optional) (Updatable) The display name of the retention rule. The name must be unique within the bucket and cannot be changed after the rule is created."
  default     = "Retention Rule"
}

variable "retention_rule_duration_time_amount" {
  type        = number
  description = "(Optional) (Updatable) The amount of time for the retention rule. The value must be a positive integer."
  default     = 1
}
variable "retention_rule_duration_time_unit" {
  type        = string
  description = "(Optional) (Updatable) The unit of time for the retention rule. Allowed values are: Days, Months, Years."
  default     = "Days"
}
variable "retention_rule_time_rule_locked" {
  type        = string
  description = "(Optional) (Updatable) The date and time when the retention rule is locked, in RFC 3339 format. Use 'no date' to indicate no lock."
  default     = null

  validation {
    condition = var.retention_rule_time_rule_locked == null || can(regex("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(Z|[+-]\\d{2}:\\d{2})$", var.retention_rule_time_rule_locked))
    error_message = "The value must be null or a valid RFC 3339 date and time string (e.g., '2025-05-04T12:34:56Z')."
  }
}