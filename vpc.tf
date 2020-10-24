module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  version            = "2.62.0"
  name               = format("foundryvtt-infrastructure-%s-vpc", var.name)
  cidr               = var.vpc_cidr
  azs                = [format("%s%s", var.region, var.availability_zone)]
  public_subnets     = [cidrsubnet(var.vpc_cidr, 8, 0)]
  private_subnets    = [cidrsubnet(var.vpc_cidr, 8, 1)]
  enable_nat_gateway = true
}