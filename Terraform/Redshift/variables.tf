variable "redshift_dbname" {
    description = "Nome do primeiro banco de dados criado no redshift cluster"
    type = string
}

variable "redshift_admin_username" {
    description = "Nome do usuário admin do primeiro banco de dados criado no redshift cluster"
    type = string
}

variable "redshift_admin_password" {
    description = "Senha do usuário admin do primeiro banco de dados criado no redshift cluster"
    type = string
}

variable "redshift_cluster_identifier" {
    description = "Identificador do cluster"
    type = string
}

variable "redshift_node_type" {
    description = "Tipo do nó do cluster"
    type = string
}

variable "redshift_number_nodes" {
    description = "Número de nós do cluster"
    type = number
}

variable "network_security_group_id" {
    description = "ID do grupo de segurança do módulo de network"
}

variable "network_subnet_group_name" {
    description = "Nome do grupo de subnets do módulo de network"
}

