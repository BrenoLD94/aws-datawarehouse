# aws-datawarehouse
Criando um DW na nuvem AWS utilizando Terraform.

## Pré-requisitos
* Uma conta na AWS
* Terraform instalado ([Como instalar o Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))
* Usuário com as permissões necessárias:
  * Permissão para criar parte de redes
  * Permissão para criar cluster redshift
  * Permissão para criar objetos e folders no bucket
  * Permissão para criar roles

## Código criará
* Cria VPC, Subnets
* Cria Security Group, Tabela de rotas, Gateway
* Cria Credencial Role para Redshift
* Cria um Cluster Redshift
* Cria um Bucket e faz upload de alguns arquivos CSV's

## Como fazer o deploy
1. Criar chaves de acesso do usuário (access key e secret access key) [Documentação](https://docs.aws.amazon.com/pt_br/IAM/latest/UserGuide/security-creds.html)
2. Substitua as variáveis no código `main.tf` para os valores desejados.
3. Execute `terraform init`
4. Execute `terraform apply`

## O que fazer na cloud
* Substitua a linha IAM_ROLE do `load_data.sql` para o valor correto. (O código ARN do role criado - Vá em IAM -> Roles)
* Abra o *query editor v2* do cluster *Redshift* e cole o código do `load_data.sql` lá dentro e execute.  

## Referências
* Os dados foram pegos da [w3schools](https://www.w3schools.com/)

<br>

**Obs**) Por hora, toda lógica para converter os dados raw no modelo Star Schema não foram incluídos. <br>
**Obs2**) Pretendo deixar essa arquitetura mais robusta usando ferramentas de ETL tratando desde da Raw até o Redshift. (Isso não foi feito, pois foi meu primeiro contato com a AWS e preciso estudar mais) <br> :)


