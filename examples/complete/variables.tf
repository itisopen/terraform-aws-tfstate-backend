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

variable "kms_master_key_id" {
  type        = string
  description = "(Optional) (Updatable) The OCID of a master encryption key used to call the Key Management service to generate a data encryption key or to encrypt or decrypt a data encryption key."
  default     = ""
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

variable "storage_tier" {
  type        = string
  description = "(Optional) The type of storage tier of this bucket. A bucket is set to 'Standard' tier by default, which means the bucket will be put in the standard storage tier. When 'Archive' tier type is set explicitly, the bucket is put in the Archive Storage tier. The 'storageTier' property is immutable after bucket is created."
  default     = "Standard"
}

variable "versioning" {
  type        = string
  description = " (Optional) (Updatable) Set the versioning status on the bucket. By default, a bucket is created with versioning Disabled. Use this option to enable versioning during bucket creation. Objects in a version enabled bucket are protected from overwrites and deletions. Previous versions of the same object will be available in the bucket. Allowed Create values: Enabled, Disabled. Allowed Update values: Enabled, Suspended."
  default     = "Disabled"
}

variable "bucket_enabled" {
  type        = bool
  description = "Whether to create the OCI Object Storage bucket."
  default     = true
}