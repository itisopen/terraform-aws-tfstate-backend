locals {
  enabled = module.this.enabled

  bucket_enabled   = local.enabled && var.bucket_enabled
  table_enabled    = local.enabled && var.table_enabled

  table_name = local.table_enabled ? coalesce(var.table_name, module.oci_nosql_table_label.id) : ""

  terraform_backend_config_file = format(
    "%s/%s",
    var.terraform_backend_config_file_path,
    var.terraform_backend_config_file_name
  )

  terraform_backend_config_template_file = var.terraform_backend_config_template_file != "" ? var.terraform_backend_config_template_file : "${path.module}/templates/terraform.tf.tpl"

  terraform_backend_config_content = templatefile(local.terraform_backend_config_template_file, {
    bucket = try(oci_objectstorage_bucket.default[0].name, "")
    region = var.oci_region
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


    table_name          = try(oci_nosql_table.default[0].name, "")
    encrypt             = "true"
    profile             = var.profile == null ? "" : var.profile
    terraform_version   = var.terraform_version == null ? "" : var.terraform_version
    terraform_state_file = var.terraform_state_file == null ? "" : var.terraform_state_file
    namespace           = var.namespace == null ? "" : var.namespace
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

module "oci_nosql_table_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = []
  context    = module.this.context
  enabled    = local.table_enabled
}


data "oci_identity_region_subscriptions" "current" {
  tenancy_id = var.oci_tenancy_ocid
}

resource "oci_objectstorage_bucket" "default" {
  count = local.bucket_enabled ? 1 : 0

  namespace         = var.oci_namespace
  name              = substr(local.bucket_name, 0, 63)
  compartment_id    = var.compartment_id
  storage_tier      = var.storage_tier
  versioning        = var.versioning

  freeform_tags = var.tags
}

resource "oci_nosql_table" "default" {
  count                   = local.table_enabled ? 1 : 0

  # Required
  compartment_id          = var.compartment_id
  ddl_statement           = var.ddl_statement
  name                    = local.table_name

  # Optional
  defined_tags            = var.defined_tags
  freeform_tags           = var.freeform_tags
  is_auto_reclaimable     = var.is_auto_reclaimable
  table_limits {
    # Required
    max_read_units        = var.max_read_units
    max_storage_in_gbs    = var.max_storage_in_gbs
    max_write_units       = var.max_write_units
    # Optional
    capacity_mode         = var.capacity_mode
  }
}

resource "local_file" "terraform_backend_config" {
  count           = local.enabled && var.terraform_backend_config_file_path != "" ? 1 : 0
  content         = local.terraform_backend_config_content
  filename        = local.terraform_backend_config_file
  file_permission = "0644"
}