-- fazer o trigger
-- fazer o update

-- CREATE OR REPLACE FUNCTION fn_log_pessoa_update()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql AS $$
-- BEGIN
-- -- insert na tabela auditoria
-- -- registrando os dados novos, e incluindo o saldo antigo
--     INSERT INTO tb_auditoria(cod_pessoa, idade, saldo_antigo, saldo_atual)
--     VALUES(NEW.cod_pessoa, NEW.idade, OLD.saldo, NEW.saldo);
--     RETURN NEW; -- retorna o novo registro para que a operação de update aconteça normalmente
-- END;
-- $$

-- SELECT * FROM tb_auditoria;

-- INSERT INTO tb_pessoa(nome, idade, saldo) VALUES('Ana', 20, 100), ('Paula', 30, 200), ('Isabela', 20, 500);

-- ALTER TABLE tb_auditoria ADD COLUMN IF NOT EXISTS nome VARCHAR(200) NOT NULL;

-- CREATE OR REPLACE TRIGGER tg_log_pessoa_insert
-- AFTER INSERT ON tb_pessoa
-- FOR EACH ROW 
--     EXECUTE PROCEDURE fn_log_pessoa_insert();

-- CREATE OR REPLACE FUNCTION fn_log_pessoa_insert()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql AS $$
-- BEGIN
--     INSERT INTO tb_auditoria(cod_pessoa, nome, idade, saldo_antigo, saldo_atual)
--     VALUES (NEW.cod_pessoa, NEW.nome, NEW.idade, NULL, NEW.saldo);
--     RETURN NULL;
-- END;
-- $$

-- SELECT * FROM tb_pessoa;

-- INSERT INTO tb_pessoa(nome, idade, saldo) VALUES
-- ('João', 20, 100),
-- ('Pedro', 22, -100),
-- ('Maria', 22, 400);

-- escrever uma function que devolve trigger
-- é uma funcao de validacao de saldo
-- se o saldo for pelo menos zero deixar a operacao acontecer
-- caso contrario nao deixar
-- alem disso, exitir o saldo caso ele seja invalido
-- criar um trigger para vincular a funcao a tabela
-- ele deve executar antes de insert e de update tbm


-- CREATE OR REPLACE FUNCTION fn_validador_de_saldo()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql AS $$
-- BEGIN
--     IF NEW.saldo >= 0 THEN
--         RETURN NEW; -- pode deixar acontecer
--     ELSE
--         RAISE NOTICE 'Valor de saldor R$% inválido', NEW.saldo;
--         RETURN NULL;
--     END IF;
-- END;
-- $$

-- CREATE TRIGGER tg_validador_de_saldo
-- BEFORE INSERT OR UPDATE ON tb_pessoa -- tabela q esta sofrendo o vinculo
-- FOR ROW 
-- EXECUTE FUNCTION fn_validador_de_saldo();


-- CREATE TABLE tb_pessoa(
--     cod_pessoa SERIAL PRIMARY KEY,
--     nome VARCHAR(200) NOT NULL,
--     idade INT NOT NULL,
--     saldo NUMERIC(10, 2) NOT NULL
-- );

-- CREATE TABLE IF NOT EXISTS tb_auditoria(
--     cod_auditoria SERIAL PRIMARY KEY,
--     cod_pessoa INT NOT NULL,
--     idade INT NOT NULL,
--     saldo_antigo NUMERIC(10, 2),
--     saldo_atual NUMERIC(10, 2)
-- );