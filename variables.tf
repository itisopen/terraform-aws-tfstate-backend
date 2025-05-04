variable "oci_namespace" {
  type        = string
  description = "The namespace of the OCI Object Storage bucket."
  default     = ""
}

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

variable "profile" {
  type        = string
  description = "The name of the profile to use for authentication."
  default     = null
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

variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment where resources will be created."
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

variable "max_read_units" {
  type        = number
  description = "Maximum read units for the NoSQL table."
  default     = 0
}

variable "max_write_units" {
  type        = number
  description = "Maximum write units for the NoSQL table."
  default     = 0
}

variable "max_storage_in_gbs" {
  type        = number
  description = "Maximum storage in GBs for the NoSQL table."
  default     = 1
}

variable "table_enabled" {
  type        = bool
  description = "Whether to create the OCI NoSQL table."
  default     = true
}

variable "table_name" {
  type        = string
  description = "Override the name of the NoSQL table."
  default     = null
}


variable "oci_tenancy_ocid" {
  type        = string
  description = "The OCID of the tenancy."
}

variable "defined_tags" {
  type        = map(string)
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. Example: {'foo-namespace': {'bar-key': 'value'}}"
  default     = {}
}

variable "freeform_tags" {
  type        = map(string)
  description = "(Optional) (Updatable) Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only. Example: {'bar-key': 'value'}"
  default     = {}
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

variable "oci_region" {
  description = "The OCI region to deploy resources in"
  type        = string
  default     = "eu-paris-1"
}
