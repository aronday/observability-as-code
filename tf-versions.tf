terraform {
  # We version pin everything so we can test new versions in a lower env before promoting to production! 
  # Latest versions correct as of 2022/12/09
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.46.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }

    datadog = {
      source  = "DataDog/datadog"
      version = "3.18.0"
    }
  }

  required_version = ">= 1.3"
}