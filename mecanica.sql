CREATE DATABASE mecanica
GO
USE mecanica

GO
CREATE TABLE cliente(
ID_Cliente     INT              NOT NULL IDENTITY(3401,15), 
nome           VARCHAR(60)      NOT NULL,
logradouro     VARCHAR(100)     NOT NULL,
numero         INT              NOT NULL CHECK (numero > 0),
cep            CHAR(8)          NOT NULL CHECK (cep = 08),
complemento    VARCHAR(255)     NOT NULL
PRIMARY KEY (ID_Cliente)
)

GO 
CREATE TABLE telefone(
ID_Cliente     INT              NOT NULL,
telefone       INT              NOT NULL CHECK (telefone = 10)
PRIMARY KEY (ID_Cliente, telefone)
FOREIGN KEY (ID_Cliente) REFERENCES cliente (ID_Cliente)
)

GO
CREATE TABLE peca(
ID_peca      INT          NOT NULL IDENTITY(3411,7),
nome     VARCHAR(30)      NOT NULL,
preco    DECIMAL(4,2)     NOT NULL CHECK (preco > 0),
estoque  INT              NOT NULL CHECK (estoque >= 10)
PRIMARY KEY (ID_peca)
)

GO 
CREATE TABLE veiculo(
placa           CHAR(07)     NOT NULL CHECK(LEN(placa) = 7),
marca           VARCHAR(30)  NOT NULL,
modelo          VARCHAR(30)  NOT NULL CHECK (modelo > 1997),
cor             VARCHAR(15)  NOT NULL,
ano_fab         INT          NOT NULL CHECK (ano_fab > 1997),
ano_mod         INT          NOT NULL,
data_aquisicao  DATE         NOT NULL,
ID_Cliente     INT           NOT NULL
PRIMARY KEY (placa)
FOREIGN KEY (ID_Cliente) REFERENCES cliente (ID_Cliente),
CONSTRAINT chk_ano_mod_fab CHECK((UPPER(ano_mod ) >= ano_fab)) 						
)

GO
CREATE TABLE categoria (
ID_categoria      INT              NOT NULL IDENTITY(1,1), 
categoria         VARCHAR(60)      NOT NULL CHECK(((UPPER(categoria) = 'Estagiario' OR UPPER(categoria) = 'Nivel 1' OR (UPPER(categoria) = 'Nivel 2' 
OR (UPPER(categoria) = 'Nivel 3'))))),
valor_hora        DECIMAL(4,2)     NOT NULL CHECK (valor_hora > 0),
PRIMARY KEY (ID_categoria),
CONSTRAINT chk_cat_valor CHECK((UPPER(categoria) = 'Estagiario' AND( valor_hora >= 15.00)
                      OR ((UPPER(categoria) = 'Nivel 1' AND valor_hora >= 25.00)
					  OR ((UPPER(categoria) = 'Nivel 2' AND valor_hora >= 35.00)
					  OR ((UPPER(categoria) = 'Nivel 3' AND valor_hora >= 50.00))))))
)

GO
CREATE TABLE funcionario(
ID                     INT              NOT NULL IDENTITY(101,1), 
nome                   VARCHAR(60)      NOT NULL,
logradouro             VARCHAR(100)     NOT NULL,
numero                 INT              NOT NULL CHECK (numero > 0),
telefone               CHAR(11)         NOT NULL CHECK (telefone = 11),
categoria_habilitacao  VARCHAR(02)      NOT NULL CHECK(((UPPER(categoria_habilitacao) = 'A' OR UPPER(categoria_habilitacao) = 'B' OR (UPPER(categoria_habilitacao) = 'C' 
OR (UPPER(categoria_habilitacao) = 'D' OR (UPPER(categoria_habilitacao) = 'E')))))),
ID_categoria           INT              NOT NULL
PRIMARY KEY (ID)
FOREIGN KEY (ID_categoria) REFERENCES categoria(ID_categoria)
)

GO
CREATE TABLE reparo(
data_reparo       DATE             NOT NULL DEFAULT('23-10-2023'),
custo_total       DECIMAL(4,2)     NOT NULL CHECK (custo_total > 0),
tempo             INT              NOT NULL CHECK (tempo > 0),
placa             CHAR(07)         NOT NULL,
ID                INT              NOT NULL,
ID_peca           INT              NOT NULL
PRIMARY KEY (data_reparo, placa, ID, ID_peca)
FOREIGN KEY (placa) REFERENCES veiculo (placa),
FOREIGN KEY (ID) REFERENCES funcionario (ID),
FOREIGN KEY (ID_peca) REFERENCES peca (ID_peca)
)

