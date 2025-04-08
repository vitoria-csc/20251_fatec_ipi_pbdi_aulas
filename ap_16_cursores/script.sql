DO
$$
DECLARE
--1. declaracao do cursor
--esse cursor é não vinculado (unbound), pois quando declaramos não especificamos SELECT
cur_nomes_youtubers REFCURSOR;
v_youtuber VARCHAR(200); --a cada FETCH o v_youtuber guarda um dos nomes
BEGIN
--2. abertura do cursor
OPEN cur_nomes_youtubers FOR
SELECT youtuber
FROM tb_top_youtubers;
LOOP
--3. recuperacao dos dados de interesse
	FETCH cur_nomes_youtubers
	INTO v_youtuber;
	EXIT WHEN NOT FOUND;
	RAISE NOTICE '%', v_youtuber;
END LOOP;
CLOSE cur_nomes_youtubers;

--4. fechamento do cursor

END;
$$

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