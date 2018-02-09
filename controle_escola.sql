-- Aula6 BD - 26/01/2017

/*
	Estudo de caso:
	
	Uma escola necessita armazenar os dados de seus alunos: nome, genero e data de nascimento.
	
	Além dos dados do aluno, os dados das disciplinas que esses alunos podem cursar também
	devem ser armazenados. Os dados das disciplina são: nome, carga horária, professor e 
	grau de escolaridade do professor.
	
	Um professor pode lecionar mais de uma disciplina, já uma disciplina pode ser lecionada
	por apenas um professor.

	No ano letivo em que um aluno cursa uma disciplina ele obtém 3 notas. As notas são 
	utilizadas para gerar média e verificar a condição de aprovação do aluno em uma disciplina.
	
**/

DROP DATABASE aula6;
CREATE DATABASE aula6;
\c aula6

CREATE TABLE aluno (
	matricula 	INTEGER 	PRIMARY KEY,
	nome 		VARCHAR(30)	NOT NULL,
	genero 		CHAR(1)		NOT NULL,
	dataNasc 	DATE		NOT NULL);
	
CREATE TABLE professor (
	codigoProf 	 INTEGER 		PRIMARY KEY,
	nome	 	 VARCHAR(30)	NOT NULL,
	escolaridade VARCHAR(30)	NOT NULL);
	
CREATE TABLE disciplina (
	codigoDisc 	INTEGER 	PRIMARY KEY,
	nome 		VARCHAR(30)	NOT NULL,
	cargaHr 	INTEGER		NOT NULL,
	cod_prof 	INTEGER,
	FOREIGN KEY(cod_prof) 	REFERENCES Professor (codigoProf));

CREATE TABLE alunosInscritos (
	anoLetivo 	INTEGER,
	cod_disc	INTEGER,
	mat_aluno 	INTEGER,
	nota1 FLOAT DEFAULT 0,
	nota3 FLOAT,
	nota2 FLOAT,
	PRIMARY KEY(anoLetivo, cod_disc, mat_aluno),
	FOREIGN KEY(cod_disc) REFERENCES disciplina (codigoDisc),
	FOREIGN KEY(mat_aluno) REFERENCES aluno (matricula));

\d
\d aluno
\d professor
\d disciplina
\d alunosInscritos

-- Sequencias.
CREATE SEQUENCE seqmat;
CREATE SEQUENCE seqprof START WITH 110 INCREMENT BY 10;
CREATE SEQUENCE seqcod;

-- Inserir dados nas tabelas.

INSERT INTO aluno VALUES(NEXTVAL('seqmat'), 'Leo', 'm', '1993-10-21'),
						(NEXTVAL('seqmat'), 'Ana', 'f', '1989-06-19'),
						(NEXTVAL('seqmat'), 'Bia', 'f', '1994-03-05'),
						(NEXTVAL('seqmat'), 'Edu', 'm', '1986-08-18'),
						(NEXTVAL('seqmat'), 'Nat', 'f', '1988-12-27'),
						(NEXTVAL('seqmat'), 'Rui', 'm', '1991-02-15'),
						(NEXTVAL('seqmat'), 'Mel', 'f', '1990-07-02');
						
SELECT * FROM aluno;


INSERT INTO professor VALUES(NEXTVAL('seqprof'), 'Kiko', 'Pos-Graduado'),
							(NEXTVAL('seqprof'), 'Mila', 'Graduado'),
							(NEXTVAL('seqprof'), 'Rita', 'Mestrado');
						
SELECT * FROM professor;

INSERT INTO disciplina VALUES(NEXTVAL('seqcod'), 'BD', 32, 110),
							 (NEXTVAL('seqcod'), 'SQL Server', 32, 120),
							 (NEXTVAL('seqcod'), 'BI', 40, 120),
							 (NEXTVAL('seqcod'), 'Oracle', 32, 130),
							 (NEXTVAL('seqcod'), 'PHP', 40, 110),
							 (NEXTVAL('seqcod'), 'UML', 20, 110),
							 (NEXTVAL('seqcod'), 'Java', 96, 130);
						
SELECT * FROM disciplina;

INSERT INTO alunosInscritos VALUES(2015, 2, 5);

SELECT * FROM alunosInscritos;

UPDATE alunosInscritos SET nota1 = 6.5
	WHERE anoLetivo = 2015 AND mat_aluno = 5
	AND cod_disc = 2;
	
UPDATE alunosInscritos SET nota2 = 7
	WHERE anoLetivo = 2015 AND mat_aluno = 5
	AND cod_disc = 2;
	
UPDATE alunosInscritos SET nota3 = 4
	WHERE anoLetivo = 2015 AND mat_aluno = 5
	AND cod_disc = 2;
	
SELECT * FROM alunosInscritos;

INSERT INTO alunosInscritos VALUES(2015, 3, 2, 7, 3, 5);
INSERT INTO alunosInscritos VALUES(2015, 4, 6, 5, 7, 4);
INSERT INTO alunosInscritos VALUES(2015, 1, 1, 6.5, 6, 6);
INSERT INTO alunosInscritos VALUES(2015, 6, 3, 3.5, 4, 4);
INSERT INTO alunosInscritos VALUES(2015, 3, 5, 5.5, 6, 4);
INSERT INTO alunosInscritos VALUES(2015, 7, 2, 5, 4, 5);
INSERT INTO alunosInscritos VALUES(2015, 2, 2, 7, 7, 7);
INSERT INTO alunosInscritos VALUES(2015, 1, 5, 4, 5.5, 7);
INSERT INTO alunosInscritos VALUES(2016, 3, 6, 5, 7.5, 6);
INSERT INTO alunosInscritos VALUES(2016, 2, 7, 8, 7.5, 8);
INSERT INTO alunosInscritos VALUES(2016, 4, 3, 5, 4.5, 7);
INSERT INTO alunosInscritos VALUES(2016, 1, 2, 4, 7, 9);
INSERT INTO alunosInscritos VALUES(2016, 2, 5, 6, 6, 5);
INSERT INTO alunosInscritos VALUES(2016, 3, 2, 8.5, 6, 7);
INSERT INTO alunosInscritos VALUES(2016, 1, 5, 5.5, 7, 6);
INSERT INTO alunosInscritos VALUES(2016, 6, 6, 6, 5, 7);
INSERT INTO alunosInscritos VALUES(2016, 2, 2, 4, 5.5, 6);
INSERT INTO alunosInscritos VALUES(2016, 1, 4, 7, 8, 7);

SELECT * FROM alunosInscritos;

-- Consultas

SELECT nome, TO_CHAR(dataNasc, 'dd/mm/yyyy') AS Nascimento
	FROM aluno;
	
SELECT nome, 
	TO_CHAR(dataNasc, 'dd/mm/yyyy') AS Nascimento,
	DATE_PART('year', AGE(dataNasc)) AS Idade
	FROM aluno;

SELECT p.nome AS Professor, 
	d.nome AS disciplina, cargaHr
	FROM professor p INNER JOIN
	disciplina d ON codigoProf = cod_prof;
	
ALTER TABLE disciplina ALTER COLUMN cod_prof DROP NOT NULL;
	
INSERT INTO professor VALUES(NEXTVAL('seqprof'), 'Juca', 'Pos-Graduado');
INSERT INTO disciplina VALUES(NEXTVAL('seqcod'), 'Pyton', 40, NULL);

SELECT p.nome AS Professor, 
	d.nome AS disciplina, cargaHr
	FROM professor p LEFT JOIN
	disciplina d ON codigoProf = cod_prof;

SELECT p.nome AS Professor, 
	d.nome AS disciplina, cargaHr
	FROM professor p RIGHT JOIN
	disciplina d ON codigoProf = cod_prof;

SELECT p.nome AS Professor, 
	d.nome AS disciplina, 
	a.nome AS aluno,
	nota1, nota2, nota3
	FROM professor p 
	INNER JOIN disciplina d ON codigoProf = cod_prof
	INNER JOIN alunosInscritos ON codigoDisc = cod_disc
	INNER JOIN aluno a ON matricula = mat_aluno;

CREATE VIEW relMedias AS
SELECT anoLetivo,
	p.nome AS Professor, 
	d.nome AS disciplina, 
	a.nome AS aluno,
	(nota1 + nota2 + nota3)/3 AS Media
	FROM professor p 
	INNER JOIN disciplina d ON codigoProf = cod_prof
	INNER JOIN alunosInscritos ON codigoDisc = cod_disc
	INNER JOIN aluno a ON matricula = mat_aluno;

SELECT * FROM relMedias;	

SELECT anoLetivo, professor, disciplina, aluno,
	TO_CHAR(media, '99d99')	AS Media,
	CASE
		WHEN media >= 7 THEN 'Aprovado'
		WHEN media BETWEEN 6 AND 7 THEN 'Recuperacao'
		ELSE 'Reprovado'
	END AS Situacao
	FROM relMedias;
	
-- Exportar os dados.
\copy aluno TO 'C:/bancodedados/aluno.txt'
\copy (SELECT * FROM relMedias) TO 'C:/bancodedados/relatorioMedia.csv' DELIMITER ';'
\copy (SELECT * FROM relMedias) TO 'C:/bancodedados/relMedia.csv' DELIMITER ';' CSV HEADER

-- Tabela com a estrutura da tabela aluno
CREATE TABLE importAluno(LIKE aluno);
\d importAluno
SELECT * FROM importAluno;

-- Importar dados.
\copy importAluno FROM 'C:/bancodedados/aluno.txt'
