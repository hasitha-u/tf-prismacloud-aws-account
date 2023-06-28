terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    prismacloud = {
      source  = "PaloAltoNetworks/prismacloud"
      version = ">= 1.4.2"
    }
  }
}
