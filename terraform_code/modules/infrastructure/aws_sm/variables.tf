variable "cloud_region" {
  default = "us-east-2"
}

variable "kms_key_alias" {
    default = "alias/jalapeno-secrets-manager-key" 
}