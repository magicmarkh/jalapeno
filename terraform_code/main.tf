module "networking" {
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
  s3_vpc_endpoint_id  = module.networking.s3_vpc_endpoint_id
}

/*module "jenkins" {
  source               = "./modules/infrastructure/ec2-instances/jenkins"
  vpc_id               = module.vpc.vpc_id
  subnet_id            = module.vpc.public_subnet_id
  ami_list             = var.ami_list
  instance_type        = var.instance_type
  key_name             = var.key_name
  ssh_allowed_cidrs    = var.ssh_allowed_cidrs
  associate_public_ip  = true
  team_name            = var.team_name
  asset_owner_name     = var.asset_owner_name
}*/