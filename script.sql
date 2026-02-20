DROP TABLE Artista_Conteudo CASCADE CONSTRAINTS;
DROP TABLE Conteudo_Genero CASCADE CONSTRAINTS;
DROP TABLE Historico CASCADE CONSTRAINTS;
DROP TABLE Episodio CASCADE CONSTRAINTS;
DROP TABLE Temporada CASCADE CONSTRAINTS;
DROP TABLE Avaliacao CASCADE CONSTRAINTS;
DROP TABLE Perfil CASCADE CONSTRAINTS;
DROP TABLE Usuario CASCADE CONSTRAINTS;
DROP TABLE Assinatura CASCADE CONSTRAINTS;
DROP TABLE Conteudo CASCADE CONSTRAINTS;
DROP TABLE Genero CASCADE CONSTRAINTS;
DROP TABLE Artista CASCADE CONSTRAINTS;

DROP SEQUENCE seq_usuario;
DROP SEQUENCE seq_assinatura;
DROP SEQUENCE seq_perfil;
DROP SEQUENCE seq_avaliacao;
DROP SEQUENCE seq_conteudo;
DROP SEQUENCE seq_genero;
DROP SEQUENCE seq_artista;
DROP SEQUENCE seq_temporada;
DROP SEQUENCE seq_episodio;
DROP SEQUENCE seq_historico;

CREATE SEQUENCE seq_usuario START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_assinatura START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_perfil START WITH  1 INCREMENT BY 1;
CREATE SEQUENCE seq_avaliacao START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_conteudo START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_genero START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_artista START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_temporada START WITH  1 INCREMENT BY 1;
CREATE SEQUENCE seq_episodio START WITH  1 INCREMENT BY 1;
CREATE SEQUENCE seq_historico START WITH  1 INCREMENT BY 1;



CREATE TABLE Assinatura (
    id NUMBER,
    max_telas NUMBER NOT NULL,
    max_resolucao VARCHAR2(50),
    preco_mensal NUMBER(10,2) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_assinatura PRIMARY KEY (id),

    CONSTRAINT ck_assinatura_preco
    CHECK (preco_mensal > 0),

    CONSTRAINT ck_assinatura_telas CHECK (max_telas > 0)
);

CREATE TABLE Usuario(
    id NUMBER,
    data_cadastro DATE DEFAULT SYSDATE NOT NULL,
    data_nascimento DATE NOT NULL,
    senha VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    assinatura_id NUMBER NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY (id),
    CONSTRAINT uk_usuario_email UNIQUE(email),
    
    CONSTRAINT fk_usuario_assinatura FOREIGN KEY (assinatura_id)
    REFERENCES Assinatura(id)
);

CREATE TABLE Perfil(
    id NUMBER,
    restricao_idade NUMBER,
    url_img_avatar VARCHAR2(300),
    nome VARCHAR2(100) NOT NULL,
    usuario_id NUMBER NOT NULL,
    CONSTRAINT pk_perfil PRIMARY KEY (id),
    
    CONSTRAINT fk_usuario_perfil FOREIGN KEY(usuario_id)
    REFERENCES Usuario(id)
);


CREATE TABLE Conteudo(
    id NUMBER,
    tipo VARCHAR2(100) NOT NULL,
    duracao_minutos NUMBER,
    classificacao_indicativa NUMBER,
    ano_lancamento NUMBER(4) NOT NULL,
    sinopse CLOB,
    titulo VARCHAR2(200) NOT NULL,
    CONSTRAINT pk_conteudo PRIMARY KEY (id)
);
CREATE TABLE Avaliacao(
    id NUMBER,
    comentario CLOB,
    nota NUMBER(3,1) NOT NULL,
    data_avaliacao DATE DEFAULT SYSDATE NOT NULL,
    perfil_id NUMBER NOT NULL,
    conteudo_id NUMBER NOT NULL,
    CONSTRAINT pk_avaliacao PRIMARY KEY (id),
    
    CONSTRAINT fk_perfil_avaliacao FOREIGN KEY(perfil_id)
    REFERENCES Perfil(id),

    CONSTRAINT fk_conteudo_avaliacao FOREIGN KEY(conteudo_id)
    REFERENCES Conteudo(id),

    CONSTRAINT ck_avaliacao_nota
    CHECK (nota BETWEEN 0 AND 10),

    CONSTRAINT uk_avaliacao_perfil_conteudo UNIQUE (perfil_id, conteudo_id)
);

CREATE TABLE Genero(
    id NUMBER,
    nome VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_genero PRIMARY KEY (id),
    CONSTRAINT uk_genero_nome UNIQUE (nome)
);

CREATE TABLE Artista(
    id NUMBER,
    biografia CLOB,
    data_nascimento DATE NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_artista PRIMARY KEY (id)
    
);

CREATE TABLE Temporada(
    id NUMBER,
    data_lancamento DATE DEFAULT SYSDATE NOT NULL,
    titulo VARCHAR2(300) NOT NULL,
    numero NUMBER NOT NULL,
    conteudo_id NUMBER NOT NULL,
    CONSTRAINT pk_temporada PRIMARY KEY (id),
    
    CONSTRAINT fk_temporada_conteudo FOREIGN KEY(conteudo_id)
    REFERENCES  Conteudo(id),
    
    CONSTRAINT uk_temporada_numero UNIQUE (conteudo_id, numero),

    CONSTRAINT ck_temporada_numero CHECK (numero > 0)
);

CREATE TABLE Episodio(
    id NUMBER,
    descricao CLOB,
    titulo VARCHAR2(200) NOT NULL,
    numero NUMBER NOT NULL,
    duracao_minutos NUMBER NOT NULL,
    temporada_id NUMBER NOT NULL,
    CONSTRAINT pk_episodio PRIMARY KEY (id),

    CONSTRAINT fk_episodio_temporada FOREIGN KEY(temporada_id)
    REFERENCES Temporada(id),
    
    CONSTRAINT uk_episodio_numero UNIQUE (temporada_id, numero),

    CONSTRAINT ck_episodio_duracao CHECK (duracao_minutos > 0),

    CONSTRAINT ck_episodio_numero CHECK (numero > 0)
);

   CREATE TABLE Historico(
    id NUMBER,
    minutos_assistidos NUMBER,
    data_hora DATE DEFAULT SYSDATE NOT NULL,
    episodio_id NUMBER,
    conteudo_id NUMBER,
    perfil_id NUMBER NOT NULL,

    CONSTRAINT pk_historico PRIMARY KEY (id),

    CONSTRAINT fk_perfil_historico FOREIGN KEY (perfil_id)
        REFERENCES Perfil(id),

    CONSTRAINT fk_episodio_historico FOREIGN KEY (episodio_id)
        REFERENCES Episodio(id),

    CONSTRAINT fk_conteudo_historico  FOREIGN KEY (conteudo_id)
        REFERENCES Conteudo(id),
         CONSTRAINT ck_historico_tipo
    
    CHECK (
        (episodio_id IS NOT NULL AND conteudo_id IS NULL)
        OR
        (episodio_id IS NULL AND conteudo_id IS NOT NULL)
    ),

    CONSTRAINT ck_historico_minutos CHECK (minutos_assistidos >= 0)
);

CREATE TABLE Conteudo_Genero(
    genero_id NUMBER NOT NULL,
    conteudo_id NUMBER NOT NULL,
    CONSTRAINT pk_conteudo_genero PRIMARY KEY(genero_id, conteudo_id),
    
    CONSTRAINT fk_cg_conteudo FOREIGN KEY(conteudo_id)
    REFERENCES Conteudo(id),

    CONSTRAINT fk_cg_genero FOREIGN KEY(genero_id)
    REFERENCES Genero(id)
);

CREATE TABLE Artista_Conteudo(
    conteudo_id NUMBER NOT NULL,
    artista_id NUMBER NOT NULL,
    funcao VARCHAR2(200) NOT NULL,
    CONSTRAINT pk_artista_conteudo PRIMARY KEY(conteudo_id, artista_id),
    
    CONSTRAINT fk_ac_conteudo FOREIGN KEY(conteudo_id)
    REFERENCES Conteudo(id),

    CONSTRAINT fk_ac_artista FOREIGN KEY(artista_id)
    REFERENCES Artista(id)
);


