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

module "automation_station" {
  source            = "./modules/infrastructure/ec2_instances/automation_station"
  vpc_id            = module.vpc.vpc_id
  private_subnet_id  = module.vpc.private_subnet_id
  team_name         = var.team_name
  asset_owner_name  = var.asset_owner_name
  ami_id            = var.amzn_linux_ami_id
  key_name          = module.key_pair.key_name
  iScheduler        = var.iScheduler
  vpc_security_group_ids = [module.security_groups.ssh_internal_flat_sg_id]
}

