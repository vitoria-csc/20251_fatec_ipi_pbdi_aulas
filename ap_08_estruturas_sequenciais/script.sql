DO $$
DECLARE 
    n1 NUMERIC (5, 2); --armazenar valores
    n2 INT; --armazenar valores
    limite_inferior INT := 5;
    limite_superior INT := 17;
BEGIN
    -- 0 <= n1 < 1 (real) [0, 1)
    n1 := random();
    RAISE NOTICE 'n1: %', n1;
    -- 1 <= n1 < 10 (real) [1, 10)
    n1 := 1 + random() * 9;
    RAISE NOTICE '%', n1;
    -- floor 0.42 = 0, 1.78 = 1
    n2 := floor(random() * 10 + 1)::int;
    RAISE NOTICE 'n2: %', n2;
    n2 := floor(random() * (17 - 5 + 1) + 5)::INT; -- limita entre 5 e 17 ( limite_superior - limite inferior +1 ) + limite_inferior (quero que inclua o 17)
    RAISE NOTICE 'Intervalo qualquer: %', n2;
END;
$$

--variáveis
-- DO
-- $$
-- DECLARE
--     v_codigo INTEGER := 1;
--     v_nome_completo VARCHAR(200) := 'João';
--     v_salario NUMERIC (11, 2) := 20.5;
-- BEGIN
--     RAISE NOTICE 'Meu código é %, e chamo % e meu salário é %.', v_codigo, v_nome_completo, v_salario;
-- END;
-- $$

--placeholders de expressões em strings
-- DO
-- $$
-- BEGIN
--     RAISE NOTICE '% + % = %', 2, 2, 2+2;
-- END;
-- $$

-- DO
-- $$ -- delimitador
-- BEGIN
--     RAISE NOTICE 'Meu primeiro bloquinho anonimo';
-- END;
-- $$
-- -- CREATE DATABASE "20251_fatec_ipi_pbdi_vitoria";