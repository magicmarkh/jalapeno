provider "aws" {
  region = var.cloud_region # Change to your desired region
}

resource "aws_kms_key" "secrets_manager_key" {
  description             = "KMS key for encrypting Secrets Manager secrets"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "secrets_manager_alias" {
  name          = var.kms_key_alias
  target_key_id = aws_kms_key.secrets_manager_key.id
}

resource "aws_secretsmanager_secret" "jenkins_secret" {
  name                    = "jenkins-secret"
  description             = "AWS IAM account used for infrastructure access"
  kms_key_id              = aws_kms_key.secrets_manager_key.arn
  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "example_secret_version" {
  secret_id     = aws_secretsmanager_secret.example_secret.id
  secret_string = jsonencode({
    username = "jalapeno_infrastructure"
    password = "update_with_cybr_secrets_hub"
  })
}
