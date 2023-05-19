# cria uma rede VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "terraform-vpc-dw"
  }
}

# cria uma subnet
resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.subnet_cidr

    tags = {
        Name = "terraform-subnet-dw"
    }
}

# cria um gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "terraform-gateway-dw"
  }
}

# Cria uma tabela de rota para internet
resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gateway.id
    }
  
    tags = {
        Name = "terraform-route-table-dw"
    }
}

# associa a subnet a tabela de rota criada
resource "aws_route_table_association" "route_table_association" {
    subnet_id = aws_subnet.subnet.id
    route_table_id = aws_route_table.route_table.id 
}

resource "aws_security_group" "security_group" {
  name   = "terraform-security-group-dw"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "Redshift port"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# configura um grupo de subnets do Redshift
resource "aws_redshift_subnet_group" "redshift_subnet_group" {
  name       = "redshift-subnet-group"
  subnet_ids = [aws_subnet.subnet.id]

  tags = {
    Name = "terraform-subnet-group-dw"
  }
}