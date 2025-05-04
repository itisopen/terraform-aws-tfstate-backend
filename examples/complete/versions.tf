terraform {
  required_version = ">= 1.1.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 6.35.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.3"
    }
  }
}
