--UPDATE e DELETE com cursores
--remover tuplas em que video_count é desconhecido
--exibir as tuplas remanescentes de baixo para cima

-- select *
-- from tb_top_youtubers
-- where video_count is null;
do $$
declare
	--1. Declaração
	cur_delete REFCURSOR;
	tupla RECORD;
BEGIN
	--2. Abertura
	open cur_delete SCROLL for
		select *
		from tb_top_youtubers;
	loop
		--3. Recuperação dos dados
		fetch cur_delete into tupla;
		exit when not found;
		if tupla.video_count IS NULL THEN
			DELETE FROM tb_top_youtubers WHERE CURRENT OF cur_delete;
		end if;
	end loop;
	
	loop 
		fetch backward from cur_delete into tupla;
		exit when not found;
		raise notice '%', tupla;
	end loop;
	close cur_delete;
END;
$$








-- do $$
-- declare
-- 	v_ano int := 2010;
-- 	v_inscritos int := 6000000;
-- 	v_youtuber VARCHAR(200);
-- 	--1. Declaração
-- 	cur_ano_inscritos 
-- 	CURSOR (ano INT, inscritos INT)
-- 	FOR SELECT youtuber, 
-- 	FROM tb_top_youtubers 
-- 	WHERE started >= ano AND subscribers >= inscritos;
-- begin
-- 	--2. Abertura
-- 	open cur_ano_inscritos(v_ano,v_inscritos);
-- 	loop
-- 		fetch cur_ano_inscritos into v_youtuber;
-- 		exit when not found;
-- 		raise notice '%', v_youtuber;
-- 	end loop;
-- 	--4.Fechamento
-- 	close cur_ano_inscritos;
-- end;
-- $$
















-- --cursor vinculado (bound)
-- -- concatenar nome e número de inscritos
-- DO $$
-- DECLARE
-- 	--1. Declaração
-- 	cur_nomes_e_inscritos CURSOR FOR
-- 	SELECT youtuber, subscribers FROM tb_top_youtubers;
-- 	tupla RECORD;
-- 	resultado TEXT DEFAULT '';
-- BEGIN
-- 	--2 Abertura 
-- 	OPEN cur_nomes_e_inscritos;
-- 	fetch cur_nomes_e_inscritos INTO tupla; 
-- 	while found loop 
-- 		resultado := resultado || tupla.youtuber || ': ' ||
-- 		tupla.subscribers || ',';
-- 		--3. Recuperação de dados
-- 		FETCH cur_nomes_e_inscritos INTO tupla;
-- 	end loop;
-- 	CLOSE cur_nomes_e_inscritos;
-- 	RAISE NOTICE '%', resultado;
-- end;
-- $$

















-- --cursor não vinculado com query dinamica
-- --exibir nomes de yotubers que começaram a partir de um ano especifico
-- DO $$
-- DECLARE 
-- 		--declaração do cursor 
-- 		--não vinculado
-- 		cur_nomes_a_partir_de REFCURSOR;
-- 		v_youtuber varchar(200);
-- 		v_ano INT := 2008;
-- 		v_nome_tabela VARCHAR(200):='tb_top_youtubers';
			
-- BEGIN
-- 	--Abertura do cursor
-- 	OPEN cur_nomes_a_partir_de FOR EXECUTE
-- 	format(
-- 	'SELECT youtuber 
-- 	 FROM %s
-- 	 WHERE started >= $1', v_nome_tabela) USING v_ano;
-- 	 LOOP 
-- 	 	--3. Recuperação de dados
-- 		FETCH cur_nomes_a_partir_de INTO
-- 			v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
--      END LOOP;
-- 	--4. Fechar o cursor
-- 	CLOSE cur_nomes_a_partir_de;
-- END;
-- $$




-- DO
-- $$
-- DECLARE
-- --1. declaracao do cursor
-- --esse cursor é não vinculado (unbound), pois quando declaramos não especificamos SELECT
-- cur_nomes_youtubers REFCURSOR;
-- v_youtuber VARCHAR(200); --a cada FETCH o v_youtuber guarda um dos nomes
-- BEGIN
-- --2. abertura do cursor
-- OPEN cur_nomes_youtubers FOR
-- SELECT youtuber
-- FROM tb_top_youtubers;
-- LOOP
-- --3. recuperacao dos dados de interesse
-- 	FETCH cur_nomes_youtubers
-- 	INTO v_youtuber;
-- 	EXIT WHEN NOT FOUND;
-- 	RAISE NOTICE '%', v_youtuber;
-- END LOOP;
-- CLOSE cur_nomes_youtubers;

-- --4. fechamento do cursor

-- END;
-- $$

-- CREATE TABLE tb_top_youtubers (
-- 	cod_top_youtubers
-- 		SERIAL PRIMARY KEY,
-- 	rank INT,
-- 	youtuber VARCHAR(200),
-- 	subscribers INT,
-- 	video_views INT,
-- 	video_count INT,
-- 	category VARCHAR(200),
-- 	started INT
-- );

-- ALTER TABLE tb_top_youtubers
-- ALTER COLUMN video_views TYPE BIGINT;

-- SELECT *
-- FROM tb_top_youtubers;