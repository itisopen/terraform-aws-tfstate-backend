resource "oci_objectstorage_bucket" "default" {
  count = module.this.enabled ? 1 : 0

  # Required
  compartment_id = var.oci_compartment_id
  name           = "${module.this.id}-logs"
  namespace      = var.oci_namespace

  #Optional
  access_type = var.access_type
  auto_tiering = var.auto_tiering
  #defined_tags = {"Operations.CostCenter"= "42"}
  freeform_tags = {"Department"= "Finance"}
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
  #    time_rule_locked = var.retention_rule_time_rule_locked == null ? "" : var.retention_rule_time_rule_locked
  #}
  versioning = var.versioning
}

module "tfstate_backend" {
  source = "../../"

  bucket_enabled = var.bucket_enabled

  oci_tenancy_ocid      = var.oci_tenancy_ocid
  compartment_id  = var.oci_compartment_id
  oci_namespace   = var.oci_namespace
  
  logging = [
    {
      target_bucket = one(oci_objectstorage_bucket.default[*].name)
      target_prefix = "tfstate/"
    }
  ]

  context = module.this.context
}
