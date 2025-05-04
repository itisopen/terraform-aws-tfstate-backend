provider "oci" {
  tenancy_ocid        = var.oci_tenancy_ocid
  user_ocid           = var.oci_user_ocid
  fingerprint         = var.oci_fingerprint
  private_key_path    = var.oci_private_key_path
  region              = var.oci_region
  disable_auto_retries = false
}

provider "aws" {
  alias  = "dynamodb"
  region = var.aws_region

  #assume_role {
  #  role_arn     = var.role_arn
  #  session_name  = var.session_name
  #  external_id   = var.external_id
  #  mfa_serial    = var.mfa_serial
  #  duration      = var.duration
  #}
}