terraform {
  required_version = ">= ${terraform_version}"

  backend "s3" {
    bucket       = "${bucket}"
    oci_region   = "${oci_region}"
    aws_region   = "${aws_region}"
    aws_profile  = "${aws_profile}"
    key          = "${terraform_state_file}"
    skip_region_validation      = "${skip_region_validation}"
    skip_credentials_validation = "${skip_credentials_validation}"
    skip_requesting_account_id  = "${skip_requesting_account_id}"
    use_path_style              = "${use_path_style}"
    skip_s3_checksum            = "${skip_s3_checksum}"
    skip_metadata_api_check     = "${skip_metadata_api_check}"
    endpoints = {
      s3 = "https://<namespace>.compat.objectstorage.<region>.oraclecloud.com"
    }
    %{~ if aws_role_arn != "" ~}

    assume_role {
      aws_role_arn = "${aws_role_arn}"
    }
    %{~ endif ~}

    %{~ if dynamodb_table != "" ~}

    dynamodb_table = "${dynamodb_table}"
    %{~ endif ~}
  }
}