------------------------------------------------------------------------------------------------------
-- Inserir Registros
------------------------------------------------------------------------------------------------------

-- Fornecedor

INSERT INTO Fornecedor VALUES (1, 'Fornecedor 1', 'Porto', 111111111, 910000001);
INSERT INTO Fornecedor VALUES (2, 'Fornecedor 2', 'Porto', 222222222, 910000002);
INSERT INTO Fornecedor VALUES (3, 'Fornecedor 3', 'Porto', 333333333, 910000003);
INSERT INTO Fornecedor VALUES (4, 'Fornecedor 3', 'Porto', 444444444, 910000004);
INSERT INTO Fornecedor VALUES (5, 'Fornecedor 3', 'Porto', 555555555, 910000005);

-- Produto

INSERT INTO Produto VALUES (1, 'Produto 1', 'Kg', 25.50);
INSERT INTO Produto VALUES (2, 'Produto 2', 'Kg', 9.50);
INSERT INTO Produto VALUES (3, 'Produto 3', 'L', 40.00);
INSERT INTO Produto VALUES (4, 'Produto 4', 'L', 5.75);
INSERT INTO Produto VALUES (5, 'Produto 5', 'L', 19.99);
INSERT INTO Produto VALUES (6, 'Produto 6', 'L', 19.99);
INSERT INTO Produto VALUES (7, 'Produto 7', 'L', 19.99);

-- Armazem

INSERT INTO Armazem VALUES (1, 'Armazem 1', 'Rua da Maria', 'Porto');
INSERT INTO Armazem VALUES (2, 'Armazem 2', 'Rua de Cedofeita', 'Porto');
INSERT INTO Armazem VALUES (3, 'Armazem 3', 'Rua da Lua', 'Lisboa');
INSERT INTO Armazem VALUES (4, 'Armazem 4', 'Rua da Joana', 'Lisboa');
INSERT INTO Armazem VALUES (5, 'Armazem 5', 'Rua da Marta', 'Porto');
INSERT INTO Armazem VALUES (6, 'Parafusos', 'Avenida da Boavista', 'Porto');
INSERT INTO Armazem VALUES (7, 'Tintas', 'Avenida da Boavista', 'Porto');

-- Empregado

INSERT INTO Empregado VALUES (1, NULL, 2, 'Diogo', 'Porto', 400.50, 'Engenheiro Civil');
INSERT INTO Empregado VALUES (2, NULL, 5, 'Joel', 'Braga', 500.50, 'Engenheiro Informático');
INSERT INTO Empregado VALUES (3, NULL, 1, 'Vítor', 'Lisboa', 600.50, 'Security Expert');
INSERT INTO Empregado VALUES (4, 1, 4, 'Empregado 1', 'Lisboa', 150.00, NULL);
INSERT INTO Empregado VALUES (5, 2, 3, 'Empregado 2', 'Lisboa', 150.00, NULL);
INSERT INTO Empregado VALUES (6, 1, 6, 'Empregado 3', 'Porto', 250.00, NULL);
INSERT INTO Empregado VALUES (7, 2, 6, 'Empregado 4', 'Braga', 150.00, NULL);
INSERT INTO Empregado VALUES (8, 1, 6, 'Empregado 5', 'Lisboa', 450.00, NULL);
INSERT INTO Empregado VALUES (9, NULL, 5, 'João', 'Braga', 2000.00, 'Engenheiro Informático');\
INSERT INTO Empregado VALUES (1223, NULL, 7, 'João', 'Braga', 2000.00, 'Engenheiro Informático');

-- OrdemCompra

INSERT INTO OrdemCompra VALUES (1, 2, 3, TO_DATE('01/02/2018', 'dd/mm/yyyy'), 70.50, TO_DATE('19/10/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (2, 1, 4, TO_DATE('02/02/2018', 'dd/mm/yyyy'), 150.50, TO_DATE('20/10/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (3, 3, 5, TO_DATE('03/02/2018', 'dd/mm/yyyy'), 125.50, TO_DATE('21/10/2018', 'dd/mm/yyyy'), 1);
INSERT INTO OrdemCompra VALUES (4, 2, 3, TO_DATE('01/03/2017', 'dd/mm/yyyy'), 70.50, TO_DATE('25/03/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (5, 1, 4, TO_DATE('06/03/2018', 'dd/mm/yyyy'), 150.50, TO_DATE('29/04/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (6, 3, 5, TO_DATE('22/05/2017', 'dd/mm/yyyy'), 125.50, TO_DATE('26/05/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (7, 2, 3, TO_DATE('01/03/2017', 'dd/mm/yyyy'), 70.50, TO_DATE('25/03/2018', 'dd/mm/yyyy'), 3);
INSERT INTO OrdemCompra VALUES (8, 1, 4, TO_DATE('11/04/2017', 'dd/mm/yyyy'), 150.50, TO_DATE('29/04/2018', 'dd/mm/yyyy'), 3);
INSERT INTO OrdemCompra VALUES (9, 3, 5, TO_DATE('22/05/2017', 'dd/mm/yyyy'), 125.50, TO_DATE('26/05/2018', 'dd/mm/yyyy'), 3);
INSERT INTO OrdemCompra VALUES (10, 3, 9, TO_DATE('22/05/2017', 'dd/mm/yyyy'), 125.50, TO_DATE('26/05/2018', 'dd/mm/yyyy'), 3);
INSERT INTO OrdemCompra VALUES (11, 2, 3, TO_DATE('01/03/2017', 'dd/mm/yyyy'), 70.50, TO_DATE('25/03/2018', 'dd/mm/yyyy'), 1);
INSERT INTO OrdemCompra VALUES (12, 1, 5, TO_DATE('01/02/2018', 'dd/mm/yyyy'), 70.50, TO_DATE('19/10/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (13, 3, 5, TO_DATE('01/02/2018', 'dd/mm/yyyy'), 70.50, TO_DATE('19/10/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (14, 2, 5, TO_DATE('01/02/2018', 'dd/mm/yyyy'), 70.50, TO_DATE('19/10/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (15, 1, 5, TO_DATE('01/02/2018', 'dd/mm/yyyy'), 70.50, TO_DATE('19/10/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (16, 3, 5, TO_DATE('01/02/2018', 'dd/mm/yyyy'), 70.50, TO_DATE('19/10/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (17, 2, 5, TO_DATE('01/02/2018', 'dd/mm/yyyy'), 70.50, TO_DATE('19/10/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (18, 1, 5, TO_DATE('02/02/2018', 'dd/mm/yyyy'), 150.50, TO_DATE('20/10/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (19, 3, 5, TO_DATE('03/02/2018', 'dd/mm/yyyy'), 125.50, TO_DATE('21/10/2018', 'dd/mm/yyyy'), 1);
INSERT INTO OrdemCompra VALUES (20, 2, 5, TO_DATE('01/02/2018', 'dd/mm/yyyy'), 70.50, TO_DATE('19/10/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (21, 1, 5, TO_DATE('02/02/2018', 'dd/mm/yyyy'), 150.50, TO_DATE('20/10/2018', 'dd/mm/yyyy'), 2);
INSERT INTO OrdemCompra VALUES (22, 3, 5, TO_DATE('03/02/2018', 'dd/mm/yyyy'), 125.50, TO_DATE('21/10/2018', 'dd/mm/yyyy'), 1);
INSERT INTO OrdemCompra VALUES (23, 3, 5, TO_DATE('15/06/2018', 'dd/mm/yyyy'), 125.50, TO_DATE('17/06/2018', 'dd/mm/yyyy'), 3);
INSERT INTO OrdemCompra VALUES (24, 3, 5, TO_DATE('25/06/2018', 'dd/mm/yyyy'), 125.50, TO_DATE('29/06/2018', 'dd/mm/yyyy'), 3);
INSERT INTO OrdemCompra VALUES (25, 3, 5, TO_DATE('25/07/2018', 'dd/mm/yyyy'), 125.50, TO_DATE('02/08/2018', 'dd/mm/yyyy'), 3);
INSERT INTO OrdemCompra VALUES (26, 3, 1223, TO_DATE('25/07/2018', 'dd/mm/yyyy'), 7500.50, TO_DATE('02/08/2018', 'dd/mm/yyyy'), 3);

-- OrdemCompraProduto

INSERT INTO OrdemCompraProduto VALUES(1, 1, 2, 30, 5.00);
INSERT INTO OrdemCompraProduto VALUES(2, 2, 2, 100, 15.00);
INSERT INTO OrdemCompraProduto VALUES(3, 3, 2, 70, 20.00);
INSERT INTO OrdemCompraProduto VALUES(4, 1, 3, 250, 5.00);
INSERT INTO OrdemCompraProduto VALUES(5, 3, 1, 40, 10.00);
INSERT INTO OrdemCompraProduto VALUES(6, 2, 1, 10, 5.00);
INSERT INTO OrdemCompraProduto VALUES(7, 1, 5, 30, 5.00);
INSERT INTO OrdemCompraProduto VALUES(8, 2, 6, 100, 15.00);
INSERT INTO OrdemCompraProduto VALUES(9, 3, 4, 70, 20.00);
INSERT INTO OrdemCompraProduto VALUES(10, 1, 4, 250, 5.00);
INSERT INTO OrdemCompraProduto VALUES(11, 3, 5, 40, 10.00);
INSERT INTO OrdemCompraProduto VALUES(12, 7, 7, 50, 50.00);
INSERT INTO OrdemCompraProduto VALUES(13, 1, 3, 250, 5.00);
INSERT INTO OrdemCompraProduto VALUES(14, 3, 3, 40, 10.00);
INSERT INTO OrdemCompraProduto VALUES(15, 7, 3, 50, 50.00);
INSERT INTO OrdemCompraProduto VALUES(16, 1, 3, 250, 5.00);
INSERT INTO OrdemCompraProduto VALUES(17, 3, 3, 40, 10.00);
INSERT INTO OrdemCompraProduto VALUES(18, 7, 3, 50, 50.00);

-- FornecedorProduto

INSERT INTO FornecedorProduto VALUES(1,1,10,0.05);
INSERT INTO FornecedorProduto VALUES(2,2,22,0.3);
INSERT INTO FornecedorProduto VALUES(3,3,33,0.03);
INSERT INTO FornecedorProduto VALUES(3,1,44,0.05);
INSERT INTO FornecedorProduto VALUES(3,2,55,0.8);
INSERT INTO FornecedorProduto VALUES(4,1,66,0.15);
INSERT INTO FornecedorProduto VALUES(5,1,11,0.5);
INSERT INTO FornecedorProduto VALUES(5,2,23,0.01);
INSERT INTO FornecedorProduto VALUES(5,3,41,0.7);
INSERT INTO FornecedorProduto VALUES(2,1,26,0.02);
INSERT INTO FornecedorProduto VALUES(1,5,33,0.1);

-- ArmazemProduto

INSERT INTO ArmazemProduto VALUES (1, 2, 150, 10, 'Corredor 1', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (2, 2, 50, 10, 'Corredor 2', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (3, 2, 200, 20, 'Corredor 1', 'Prateleira 1');
INSERT INTO ArmazemProduto VALUES (4, 2, 50, 10, 'Corredor 1', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (5, 2, 50, 20, 'Corredor 3', 'Prateleira 7');
INSERT INTO ArmazemProduto VALUES (1, 1, 75, 40, 'Corredor 1', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (1, 2, 50, 10, 'Corredor 4', 'Prateleira 5');
INSERT INTO ArmazemProduto VALUES (1, 3, 250, 10, 'Corredor 6', 'Prateleira 1');
INSERT INTO ArmazemProduto VALUES (1, 4, 200, 10, 'Corredor 2', 'Prateleira 4');
INSERT INTO ArmazemProduto VALUES (6, 5, 50, 10, 'Corredor 1', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (6, 1, 150, 10, 'Corredor 1', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (6, 1, 50, 10, 'Corredor 2', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (5, 2, 300, 20, 'Corredor 1', 'Prateleira 1');
INSERT INTO ArmazemProduto VALUES (4, 2, 50, 10, 'Corredor 1', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (6, 4, 50, 20, 'Corredor 3', 'Prateleira 7');
INSERT INTO ArmazemProduto VALUES (5, 1, 75, 40, 'Corredor 1', 'Prateleira 10');
INSERT INTO ArmazemProduto VALUES (4, 2, 20, 10, 'Corredor 4', 'Prateleira 5');
INSERT INTO ArmazemProduto VALUES (6, 5, 200, 10, 'Corredor 1', 'Prateleira 1');
INSERT INTO ArmazemProduto VALUES (3, 4, 200, 10, 'Corredor 2', 'Prateleira 4');
INSERT INTO ArmazemProduto VALUES (1, 5, 50, 10, 'Corredor 1', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (6, 1, 200, 10, 'Corredor 1', 'Prateleira 1');
INSERT INTO ArmazemProduto VALUES (3, 1, 200, 10, 'Corredor 2', 'Prateleira 4');
INSERT INTO ArmazemProduto VALUES (1, 1, 50, 10, 'Corredor 1', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (2, 3, 200, 10, 'Corredor 1', 'Prateleira 1');
INSERT INTO ArmazemProduto VALUES (2, 3, 200, 10, 'Corredor 2', 'Prateleira 4');
INSERT INTO ArmazemProduto VALUES (2, 3, 50, 10, 'Corredor 1', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (1, 6, 150, 10, 'Corredor 1', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (2, 7, 50, 10, 'Corredor 2', 'Prateleira 2');
INSERT INTO ArmazemProduto VALUES (3, 6, 200, 20, 'Corredor 1', 'Prateleira 1');
INSERT INTO ArmazemProduto VALUES (4, 7, 50, 10, 'Corredor 1', 'Prateleira 2');
