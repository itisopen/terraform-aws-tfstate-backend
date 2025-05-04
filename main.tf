locals {
  enabled = module.this.enabled

  bucket_enabled   = local.enabled && var.bucket_enabled
  dynamodb_enabled = local.enabled && var.dynamodb_enabled

  dynamodb_table_name = local.dynamodb_enabled ? coalesce(var.dynamodb_table_name, module.dynamodb_table_label.id) : ""

  terraform_backend_config_file = format(
    "%s/%s",
    var.terraform_backend_config_file_path,
    var.terraform_backend_config_file_name
  )

  terraform_backend_config_template_file = var.terraform_backend_config_template_file != "" ? var.terraform_backend_config_template_file : "${path.module}/templates/terraform.tf.tpl"

  terraform_backend_config_content = templatefile(local.terraform_backend_config_template_file, {
    bucket        = try(oci_objectstorage_bucket.default[0].name, "")
    oci_region    = var.oci_region
    aws_region    = var.oci_region
    aws_role_arn  = var.aws_role_arn == null ? "" : var.aws_role_arn
    aws_profile   = var.aws_profile == null ? "" : var.aws_profile

    key    = var.terraform_state_file == null ? "tf.tfstate" : var.terraform_state_file
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
    endpoints = {
      s3 = format(
        "https://%s.compat.objectstorage.%s.oraclecloud.com",
        var.oci_namespace,
        var.oci_region
      )   
    }
    dynamodb_table = try(aws_dynamodb_table.with_server_side_encryption[0].name, "")

    terraform_version   = var.terraform_version == null ? "" : var.terraform_version
    terraform_state_file = var.terraform_state_file == null ? "" : var.terraform_state_file
    namespace           = var.oci_namespace == null ? "" : var.oci_namespace
    stage               = var.stage == null ? "" : var.stage
    environment         = var.environment == null ? "" : var.environment
    name                = var.name == null ? "" : var.name
  })

  labels_enabled = local.enabled && (var.s3_bucket_name == "" || var.s3_bucket_name == null)

  bucket_name = local.labels_enabled ? module.bucket_label.id : var.s3_bucket_name
}

module "bucket_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  enabled         = local.labels_enabled
  id_length_limit = 63

  context = module.this.context
}

data "oci_identity_region_subscriptions" "current" {
  tenancy_id = var.oci_tenancy_ocid
}

resource "oci_objectstorage_bucket" "default" {
  count = local.bucket_enabled ? 1 : 0

  # Required
  compartment_id    = var.oci_compartment_id
  name              = substr(local.bucket_name, 0, 63)
  namespace         = var.oci_namespace

  # Optional
  access_type = var.access_type
  auto_tiering = var.auto_tiering
  #defined_tags = {}
  freeform_tags = {"atmos_name"= module.this.id}
  kms_key_id = var.kms_master_key_id
  metadata = var.metadata
  object_events_enabled = var.object_events_enabled
  storage_tier = var.storage_tier
  #retention_rules {
  #    display_name = var.retention_rule_display_name
  #    duration {
  #        #Required
  #        time_amount = var.retention_rule_duration_time_amount
  #        time_unit = var.retention_rule_duration_time_unit
  #    }
  #    time_rule_locked = var.retention_rule_time_rule_locked != null ? var.retention_rule_time_rule_locked : null
  #}
  versioning = var.versioning
}

module "dynamodb_table_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = ["lock"]
  context    = module.this.context
  enabled    = local.dynamodb_enabled
}

resource "aws_dynamodb_table" "with_server_side_encryption" {
  count                       = local.dynamodb_enabled ? 1 : 0
  name                        = local.dynamodb_table_name
  billing_mode                = var.billing_mode
  read_capacity               = var.billing_mode == "PROVISIONED" ? var.read_capacity : null
  write_capacity              = var.billing_mode == "PROVISIONED" ? var.write_capacity : null
  deletion_protection_enabled = var.deletion_protection_enabled

  # https://www.terraform.io/docs/backends/types/s3.html#dynamodb_table
  hash_key = "LockID"

  server_side_encryption { #tfsec:ignore:aws-dynamodb-table-customer-key
    enabled = true
  }

  point_in_time_recovery {
    enabled = var.enable_point_in_time_recovery
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = module.dynamodb_table_label.tags
}

resource "local_file" "terraform_backend_config" {
  count           = local.enabled && var.terraform_backend_config_file_path != "" ? 1 : 0
  content         = local.terraform_backend_config_content
  filename        = local.terraform_backend_config_file
  file_permission = "0644"
}