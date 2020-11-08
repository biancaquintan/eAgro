Projeto Test ROR


Premissas básicas:

O projeto deve ter separado o frontend do Backend. Seu objetivo é criar o backend(Rails API Only). Neste projeto queremos ver:
   *Código estruturado em  micro serviços;
  *Testes funcionais;
  *Documentação da API para realizações dos testes;
  *Devemos conseguir adicionar, editar e excluir Tarefas e Projetos.
  
Modelagem Básica:

-Project
  Name
  Has Many tasks

-Task
  Date;
  Description
  Status
  ProjectID
