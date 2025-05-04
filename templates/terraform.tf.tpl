terraform {
  required_version = ">= ${terraform_version}"

  backend "s3" {
    bucket  = "${bucket}"
    region  = "${region}"
    key     = "${terraform_state_file}"
    skip_region_validation      = "${skip_region_validation}"
    skip_credentials_validation = "${skip_credentials_validation}"
    skip_requesting_account_id  = "${skip_requesting_account_id}"
    use_path_style              = "${use_path_style}"
    skip_s3_checksum            = "${skip_s3_checksum}"
    skip_metadata_api_check     = "${skip_metadata_api_check}"
    endpoints = {
      s3 = "https://<namespace>.compat.objectstorage.<region>.oraclecloud.com"
    }
    %{~ if table_name != "" ~}

    table_name = "${table_name}"
    %{~ endif ~}
  }
}