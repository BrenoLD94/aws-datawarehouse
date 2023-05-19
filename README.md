# aws-datawarehouse
Modelando e criando um DW na nuvem AWS utilizando Terraform

## Pré-requisitos
* Uma conta na AWS
* Terraform instalado
* Usuário com as permissões necessárias

## Código criará
* Cria VPC, Subnets
* Cria Security Group, Tabela de rotas, Gateway
* Cria Credencial Role para Redshift
* Cria um Cluster Redshift
* Cria um Bucket e faz upload de alguns arquivos CSV's

## Como fazer o deploy
1. Substitua as variáveis no código `main.tf` para os valores desejados.
2. Execute `terraform init`
3. Execute `terraform apply`

O `load_data.sql` será usado para copiar os dados do bucket para o Redshift. Depois de criado a infra, vá ao IAM e copie o código *arn* do role criado e cole no `load_data.sql`.

```

COPY refined.dim_cliente
FROM 's3://terraform-raw-dw-nuvem/dados/dim_cliente'
IAM_ROLE 'SUBSTITUA O ARN DO ROLE AQUI'
CSV;

```

<br>

Obs) Por hora, toda lógica para converter os dados raw no modelo Star Schema não foram incluídos. <br>
Obs2) Pretendo deixar essa arquitetura mais robusta usando ferramentas de ETL. (Isso não foi feito, pois foi meu primeiro contato com a AWS e preciso estudar mais) <br> :)
