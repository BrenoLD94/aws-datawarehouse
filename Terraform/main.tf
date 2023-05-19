terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }

  required_version = ">= 1.4.5"
}

provider "aws" {
  access_key = "" # Coloque sua chave aqui                     
  secret_key = "" # Coloque sua chave aqui
  region     = "" # região na qual os recursos serão criados
}

module "network" {
  source = "./Network"

  vpc_cidr    = "30.3.0.0/16"
  subnet_cidr = "30.3.1.0/24"
}

module "redshift" {
  source                    = "./Redshift"
  network_security_group_id = module.network.security_group_id
  network_subnet_group_name = module.network.subnet_group_name

  redshift_cluster_identifier = "terraform-redshift-cluster"
  redshift_dbname             = "" # Nome do schema
  redshift_admin_username     = "" # escolha seu usuário
  redshift_admin_password     = "" # escolha sua senha (A senha precisa satisfazer os requisitos minimos definido pelo admin da conta)
  redshift_node_type          = "dc2.large" # Tipo da máquina do cluster
  redshift_number_nodes       = 1 # Quantidade de máquinas do cluster
}

module "bucket" {
  source = "./Bucket"

  bucket_name = "terraform-raw-dw-nuvem"
}



