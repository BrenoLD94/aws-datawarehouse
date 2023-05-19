# configura um cluster Redshift
resource "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier = var.redshift_cluster_identifier
  database_name      = var.redshift_dbname
  master_username    = var.redshift_admin_username
  master_password    = var.redshift_admin_password
  node_type          = var.redshift_node_type
  number_of_nodes    = var.redshift_number_nodes 

  vpc_security_group_ids = [var.network_security_group_id]
  cluster_subnet_group_name = var.network_subnet_group_name
  iam_roles = [aws_iam_role.redshift_role.arn]
  skip_final_snapshot = true
}

# cria um papel
resource "aws_iam_role" "redshift_role" {
  name = "Redshift_S3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "redshift.amazonaws.com"
        }
      }
    ]
  }) 
}

# atribui a política ao papel especificado
resource "aws_iam_role_policy_attachment" "redshift_policy_attachment_s3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role = aws_iam_role.redshift_role.name
}