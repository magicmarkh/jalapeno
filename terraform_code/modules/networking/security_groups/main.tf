resource "aws_security_group" "ssh_from_trusted_ips" {
  name        = "${var.team_name}-trusted-external-ssh-sg"
  description = "Allow SSH only from trusted IPs"
  vpc_id      = var.vpc_id

dynamic "ingress" {
  for_each = var.trusted_ips
  content {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ingress.value]
  }
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.team_name}-trusted-ip-ssh-sg"
    Owner = var.asset_owner_name
  }
}

resource "aws_security_group" "rdp_from_trusted_ips" {
  name        = "${var.team_name}-trusted-external-rdp-sg"
  description = "Allow RDP only from trusted IPs"
  vpc_id      = var.vpc_id

dynamic "ingress" {
  for_each = var.trusted_ips
  content {
    description = "rdp access"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [ingress.value]
  }
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.team_name}-trusted-ip-rdp-sg"
    Owner = var.asset_owner_name
  }
}

resource "aws_security_group" "ssh_internal_flat" {
  name        = "${var.team_name}-internal-flat-ssh-sg"
  description = "Allow SSH only from internal subnets"
  vpc_id      = var.vpc_id

dynamic "ingress" {
  for_each = var.internal_subnets
  content {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ingress.value]
  }
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.team_name}-trusted-ip-ssh-sg"
    Owner = var.asset_owner_name
  }
}

resource "aws_security_group" "rdp_internal_flat" {
  name        = "${var.team_name}-internal-flat-rdp-sg"
  description = "Allow RDP only from internal subnets"
  vpc_id      = var.vpc_id

dynamic "ingress" {
  for_each = var.internal_subnets
  content {
    description = "RDP access"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [ingress.value]
  }
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.team_name}-internal-flat-rdp-sg"
    Owner = var.asset_owner_name
  }
}

resource "aws_security_group" "jenkins_8080" {
  name        = "${var.team_name}-jenkins-8080-sg"
  description = "8080"
  vpc_id      = var.vpc_id

dynamic "ingress" {
  for_each = var.internal_subnets
  content {
    description = "Jenkins Web Access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [ingress.value]
  }
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.team_name}-jenkins-8080-sg"
    Owner = var.asset_owner_name
  }
}

locals {
  domain_controller_ports = [
    {
      description = "DNS TCP"
      from_port   = 53
      to_port     = 53
      protocol    = "tcp"
    },
    {
      description = "DNS UDP"
      from_port   = 53
      to_port     = 53
      protocol    = "udp"
    },
    {
      description = "LDAP TCP"
      from_port   = 389
      to_port     = 389
      protocol    = "tcp"
    },
    {
      description = "LDAP UDP"
      from_port   = 389
      to_port     = 389
      protocol    = "udp"
    },
    {
      description = "Kerberos TCP"
      from_port   = 88
      to_port     = 88
      protocol    = "tcp"
    },
    {
      description = "Kerberos UDP"
      from_port   = 88
      to_port     = 88
      protocol    = "udp"
    },
    {
      description = "Global Catalog LDAP"
      from_port   = 3268
      to_port     = 3268
      protocol    = "tcp"
    },
    {
      description = "Netlogon"
      from_port   = 445
      to_port     = 445
      protocol    = "tcp"
    },
    {
      description = "RPC Endpoint Mapper"
      from_port   = 135
      to_port     = 135
      protocol    = "tcp"
    },
    {
      description = "Ephemeral Ports"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
    }
  ]
}

resource "aws_security_group" "domain_controller_sg" {
  name        = "domain-controller-sg"
  description = "Security Group for Windows 2016 Domain Controller (AD & DNS)"
  vpc_id      = var.vpc_id

   dynamic "ingress" {
    for_each = local.domain_controller_ports
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = var.internal_subnets
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "domain-controller-sg"
  }
}
