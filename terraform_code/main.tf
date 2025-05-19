module "vpc" {
  source      = "./modules/networking/vpc"
  region = var.region
  asset_owner_name = var.asset_owner_name
  team_name = var.team_name
  private_subnet_az = var.private_subnet_az
  public_subnet_az = var.public_subnet_az
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "s3_bucket" {
  source              = "./modules/s3_bucket"
  region              = var.region
  asset_owner_name    = var.asset_owner_name
  bucket_name         = var.team_name
  s3_vpc_endpoint_id  = module.vpc.s3_vpc_endpoint_id
}

module "key_pair"{
  source = "./modules/security/key_pair"
  server_key_name = "${var.team_name}-key"
  team_name = var.team_name
  asset_owner_name = var.asset_owner_name
}

module "security_groups" {
  source = "./modules/networking/security_groups"
  asset_owner_name = var.asset_owner_name
  vpc_id = module.vpc.vpc_id
  trusted_ips = var.trusted_ips
  team_name = var.team_name
  internal_subnets = ["${var.public_subnet_cidr}","${var.private_subnet_cidr}"]
}

module "ec2_public_server" {
  source            = "./modules/infrastructure/ec2_instances/ec2_public_server"
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  team_name         = var.team_name
  asset_owner_name  = var.asset_owner_name
  linux_ami_id      = var.amzn_linux_ami_id
  windows_ami_id = var.amzn_windows_server_ami_id
  key_name          = module.key_pair.key_name
  trusted_ips       = var.trusted_ips
  iScheduler        = var.iScheduler
  linux_security_group_ids = module.security_groups.trusted_ssh_external_security_group_id
  windows_security_group_ids = module.security_groups.trusted_rdp_external_security_group_id
}

module "iam_roles" {
  source = "./modules/security/iam_roles"
  team_name = var.team_name
  s3_bucket_arn = module.s3_bucket.bucket_arn
  vpc_arn = module.vpc.vpc_arn
  asset_owner_name = var.asset_owner_name
}


module "automation_station" {
  source            = "./modules/infrastructure/ec2_instances/automation_station"
  vpc_id            = module.vpc.vpc_id
  private_subnet_id  = module.vpc.private_subnet_id
  team_name         = var.team_name
  asset_owner_name  = var.asset_owner_name
  ami_id            = var.amzn_linux_ami_id
  key_name          = module.key_pair.key_name
  iScheduler        = var.iScheduler
  vpc_security_group_ids = [module.security_groups.ssh_internal_flat_sg_id,module.security_groups.jenkins_8080_flat_sg_id]
  private_ip_address = var.automation_station_private_ip
}

module "dc" {
  source            = "./modules/infrastructure/ec2_instances/dc"
  vpc_id            = module.vpc.vpc_id
  team_name         = var.team_name
  asset_owner_name  = var.asset_owner_name
  windows_ami_id = var.amzn_windows_server_ami_id
  key_name          = module.key_pair.key_name
  iScheduler        = var.iScheduler
  security_group_ids = [module.security_groups.rdp_internal_flat_sg_id,module.security_groups.domain_controller_sg_id]
  private_ip = var.dc1_private_ip
  private_subnet_id = module.vpc.private_subnet_id
}

module "targets" {
  source = "./modules/infrastructure/ec2_instances/targets"
  vpc_id = module.vpc.vpc_id
  team_name = var.team_name
  asset_owner_name = var.asset_owner_name
  windows_ami_id = var.amzn_windows_server_ami_id
  key_name = module.key_pair.key_name
  iScheduler = var.iScheduler
  linux_ami_id = var.amzn_linux_ami_id
  windows_security_group_ids = module.security_groups.rdp_internal_flat_sg_id
  linux_security_group_ids = module.security_groups.ssh_internal_flat_sg_id
  private_subnet_id = module.vpc.private_subnet_id
  windows_target_1_private_ip = var.windows_target_1_private_ip
  linux_target_1_private_ip = var.linux_target_1_private_ip
}

module "cyberark_connectors" {
  source = "./modules/infrastructure/ec2_instances/cyberark_connectors"
  vpc_id = module.vpc.vpc_id
  team_name = var.team_name
  asset_owner_name = var.asset_owner_name
  windows_ami_id = var.amzn_windows_server_ami_id
  key_name = module.key_pair.key_name
  iScheduler = var.iScheduler
  windows_security_group_ids = module.security_groups.rdp_internal_flat_sg_id
  private_subnet_id = module.vpc.private_subnet_id
  connector_1_private_ip = var.connector_1_private_ip
  sia_aws_connector_1_private_ip = var.sia_aws_connector_1_private_ip
}

module "aws_sm_secrets" {
  source = "./modules/infrastructure/aws_sm_secrets"
  domain_join_password = var.domain_join_password
  domain_join_secret_name = var.domain_join_secret_name
  domain_join_username = var.domain_join_username
}

module "secrets_hub_onboarding_role"{
  source = "./modules/security/iam_roles/secrets_hub_onboarding_role"
  SecretsManagerRegion = var.region
  CyberArkSecretsHubRoleARN = var.CyberArkSecretsHubRoleARN
}