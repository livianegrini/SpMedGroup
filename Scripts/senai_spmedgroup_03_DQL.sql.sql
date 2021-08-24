USE SPMEDICALGROUP_Livia;
GO

--Selecionando Tabelas para Visualização.
SELECT * FROM TipoUsuario
SELECT * FROM Usuario
SELECT * FROM Paciente
SELECT * FROM Medico
SELECT * FROM Endereco
SELECT * FROM Especialidade
SELECT * FROM Clinica
SELECT * FROM Situacao
SELECT * FROM Consulta

-- Quantidade de Usuários
SELECT COUNT(IdUsuario) 'Quantidade Usuários' FROM Usuario;
GO

--Usuario e Tipo de Usuario
SELECT IdUsuario,Email,TipoUsuario
FROM Usuario
INNER JOIN TipoUsuario
ON Usuario.IdTipoUsuario = TipoUsuario.IdTipoUsuario

--Mostrar Médicos e Epecialidades
SELECT Nome Medico,Especialidade
FROM Medico
INNER JOIN Usuario
ON Medico.IdUsuario = Usuario.IdUsuario
INNER JOIN Especialidade
ON Medico.IdEspecialidade = Especialidade.IdEspecialidade
GO

--Mostrar Médicos, Epecialidade e Nome da Clinica
SELECT Crm,Nome Medico,Email,Especialidade,NomeFantasia Clinica
FROM Medico
INNER JOIN Usuario
ON Medico.IdUsuario = Usuario.IdUsuario
INNER JOIN Especialidade
ON Medico.IdEspecialidade = Especialidade.IdEspecialidade
INNER JOIN Clinica
ON Medico.IdClinica = Clinica.IdClinica
GO

--Prontuários
SELECT Nome,Email,DataNascimento,Telefone,Rg,Cpf,Logadouro,Numero,Bairro,Municipio,Estado,Cep
FROM Paciente
INNER JOIN Usuario
ON Paciente.IdUsuario = Usuario.IdUsuario
INNER JOIN Endereco
ON Paciente.IdEndereco = Endereco.IdEndereco
GO

-- Converter Data da Consulta do Usuário para Formato (mm-dd-yyyy) 
SELECT FORMAT (DataCon, 'dd/MM/yyyy')[Data Consulta]  FROM Consulta;
GO

--Consultas
SELECT Paciente.Nome Paciente,Medico.Nome Medico,DataCon  DataConsulta,Hora HoraConsulta, TipoSituacao
FROM Consulta
INNER JOIN Paciente
ON Consulta.IdPaciente = Paciente.IdPaciente
INNER JOIN Medico
ON  Consulta.IdMedico = Medico.IdMedico
INNER JOIN Situacao
ON Consulta.IdSituacao = Situacao.IdSituacao
GO

-- Converter Data de Nascimento do Usuário para Formato (mm-dd-yyyy) 
SELECT FORMAT (DataNascimento, 'dd/MM/yyyy')[Data Nascimento]  FROM Paciente;
GO

--Função
CREATE FUNCTION SituacaoConsulta()
RETURNS TABLE
AS
RETURN
 SELECT Paciente.Nome Paciente, Medico.Nome Medico,DataCon DataConsulta,Hora HoraConsulta,TipoSituacao
 FROM Consulta
 INNER JOIN Paciente
 ON Consulta.IdPaciente = Paciente.IdPaciente
 INNER JOIN Medico
 ON Consulta.IdMedico = Medico.IdMedico
 INNER JOIN Situacao
 ON Consulta.IdSituacao = Situacao.IdSituacao;
 GO

 --Stored Procedure// Retorna número de consultas de um médico específico
 
 CREATE PROCEDURE QuantidadeConsultas
@Nome VARCHAR(30)
    AS
 BEGIN
 SELECT Consulta, Medico.Nome
 FROM Consulta
 INNER JOIN Medico
 ON Consulta.IdMedico = Medico.IdMedico
END;
GO

EXEC QuantidadeConsultas'Ricardo Lemos';
GO
