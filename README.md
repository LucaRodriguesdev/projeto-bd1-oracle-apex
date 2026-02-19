**Modelo de Banco de Dados – Plataforma de Streaming**
Projeto de modelagem e implementação de um ecossistema de streaming (estilo Netflix), desenvolvido em Oracle SQL para a disciplina de Banco de Dados.

📌 Visão Geral
O projeto contempla o fluxo completo de uma plataforma: gestão de assinaturas, perfis de usuário, catálogo de conteúdos (filmes/séries), avaliações e progresso de visualização.

**🛠 Tecnologias Utilizadas**
SGBD: Oracle SQL

Objetos: DDL (Tables, Sequences, Constraints)

Integridade: PKs, FKs nomeadas e Unique Keys

Regras: CHECK Constraints para validação de domínio

**🧱 Estrutura de Dados**
Acesso: Usuário, Assinatura e Perfil

Catálogo: Conteúdo, Temporada, Episódio, Gênero e Artista

Interação: Avaliação e Histórico de Visualização

**🔒 Regras de Negócio Implementadas**
Validação de E-mail: Unicidade obrigatória para acesso

Lógica XOR: Histórico vinculado exclusivamente a um episódio ou conteúdo

Integridade Referencial: Constraints nomeadas para fácil manutenção

**📂 Arquivos do Projeto**
script.sql → Código SQL completo (DDL)

DER.png → Diagrama Entidade-Relacionamento

👨‍💻 Autor
Luca Rodrigues
