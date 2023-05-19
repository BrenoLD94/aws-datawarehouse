CREATE SCHEMA IF NOT EXISTS refined;


CREATE TABLE IF NOT EXISTS refined.dim_cliente (
	SK_CLIENTE INT NOT NULL,
	ID_CLIENTE INT NOT NULL, 
	NOME VARCHAR(100) NOT NULL,
	CIDADE VARCHAR(50),
	PAIS VARCHAR(50),
	CONSTRAINT dim_cliente_pkey PRIMARY KEY (SK_CLIENTE)
);

CREATE TABLE IF NOT EXISTS refined.dim_tempo (
	SK_TEMPO INT NOT NULL,
	ID_TEMPO INT NOT NULL,
	DIA INT NOT NULL,
	MES INT NOT NULL,
	ANO INT NOT NULL,
	DATA_COMPLETA DATE NOT NULL,
	CONSTRAINT dim_tempo_pkey PRIMARY KEY (SK_TEMPO)
);

CREATE TABLE IF NOT EXISTS refined.dim_funcionario (
	SK_FUNC INT NOT NULL,
	ID_FUNC INT NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	DATA_ANIVERSARIO DATE NOT NULL,
	CONSTRAINT dim_funcionario_pkey PRIMARY KEY (SK_FUNC)
);

CREATE TABLE IF NOT EXISTS refined.dim_produto (
	SK_PRODUTO INT NOT NULL,
	ID_PRODUTO INT NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	CATEGORIA VARCHAR(50) NOT NULL,
	CONSTRAINT dim_produto_pkey PRIMARY KEY (SK_PRODUTO)
);

CREATE TABLE IF NOT EXISTS refined.fato_vendas (
	SK_CLIENTE INT NOT NULL,
	SK_TEMPO INT NOT NULL,
	SK_FUNC INT NOT NULL,
	SK_PRODUTO INT NOT NULL,
	QUANTIDADE INT NOT NULL,
	PRECO NUMERIC(10,2) NOT NULL,
	PRIMARY KEY(SK_CLIENTE, SK_TEMPO, SK_FUNC, SK_PRODUTO),
	FOREIGN KEY (SK_CLIENTE) REFERENCES refined.dim_cliente(SK_CLIENTE),
	FOREIGN KEY (SK_TEMPO) REFERENCES refined.dim_tempo(SK_TEMPO),
	FOREIGN KEY (SK_FUNC) REFERENCES refined.dim_funcionario(SK_FUNC),
	FOREIGN KEY (SK_PRODUTO) REFERENCES refined.dim_produto(SK_PRODUTO)
);

COPY refined.dim_cliente
FROM 's3://terraform-raw-dw-nuvem/dados/dim_cliente'
IAM_ROLE 'arn:aws:iam::285337151678:role/Redshift_S3_access_role'
CSV;

COPY refined.dim_tempo
FROM 's3://terraform-raw-dw-nuvem/dados/dim_tempo'
IAM_ROLE 'arn:aws:iam::285337151678:role/Redshift_S3_access_role'
CSV;

COPY refined.dim_funcionario
FROM 's3://terraform-raw-dw-nuvem/dados/dim_funcionario'
IAM_ROLE 'arn:aws:iam::285337151678:role/Redshift_S3_access_role'
CSV;

COPY refined.dim_produto
FROM 's3://terraform-raw-dw-nuvem/dados/dim_produto'
IAM_ROLE 'arn:aws:iam::285337151678:role/Redshift_S3_access_role'
CSV;

COPY refined.fato_vendas
FROM 's3://terraform-raw-dw-nuvem/dados/fato_vendas'
IAM_ROLE 'arn:aws:iam::285337151678:role/Redshift_S3_access_role'
CSV;