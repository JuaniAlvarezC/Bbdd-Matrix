SELECT jc.Resume FROM HumanResources.JobCandidate jc
INNER JOIN HumanResources.Employee e on jc.BusinessEntityID =e.BusinessEntityID
ORDER BY e.BusinessEntityID,jc.JobCandidateID;
/*
Puesto que toda la información que requiere para responder la consulta está en jc, primero hace un full scan de la tabla, la ordena y luego procede a hacer el join con e, que en realidad basta con verficar haciendo un index seek que el índice jc.BusinessEntityID esté en e.BusinessEntityID. Es por esto que hace un Nested Loops tal que el loop de adentro es el de e, puesto que estima que hay menos elementos en esa tabla
*/

SELECT JobCandidateID FROM HumanResources.JobCandidate jc
INNER JOIN HumanResources.Employee e on jc.BusinessEntityID =e.BusinessEntityID
ORDER BY e.BusinessEntityID,jc.JobCandidateID;
/*
Puesto que se tiene en jc un IX ordenado por BusinessEntityID y que en e la PK es BusinessentityID, decide simplemente hacer un Nested Loop siendo el Inner e. Es entonces que el JOIN lo resuelve buscando los valores del IX de jc en la PK de e y luego procede a devolver el valor requerido que se almacena en IX puesto que es la PK de jc
*/
--1--
SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID = 870 OR ProductID = 897;

SELECT * FROM Sales.SalesOrderDetail 
WHERE ProductID = 870
UNION ALL
SELECT * FROM Sales.SalesOrderDetail 
WHERE ProductID = 897;

DECLARE @productId INT = 897;

--SELECT * FROM Sales.SalesOrderDetail WHERE ProductID = @productId
--OPTION( OPTIMIZE FOR (@productId = 897) );

SELECT * FROM Sales.SalesOrderDetail WHERE ProductID = @productId
OPTION( OPTIMIZE FOR (@productId = 870) );


-- Consulta A

SELECT * FROM Sales.SalesOrderDetail 

WHERE ProductID = 897;


-- Consulta B

DECLARE @prodId INT = 897;

SELECT * FROM Sales.SalesOrderDetail 

WHERE ProductID = @prodId;


--4--
SELECT * FROM Sales.SalesOrderDetail d
JOIN Production.Product p ON d.ProductID = p.ProductID;

-- Consulta B
SELECT * FROM Sales.SalesOrderDetail d
JOIN Production.Product p ON d.ProductID = p.ProductID
WHERE p.Name LIKE 'A%';

--5--
-- Consulta A

SELECT * 
FROM Sales.SalesOrderDetail d
JOIN Production.Product p 
  ON d.ProductID = p.ProductID
WHERE p.ProductID = 870;


-- Consulta B

SELECT * 
FROM Sales.SalesOrderDetail d
JOIN Production.Product p 
  ON d.ProductID = p.ProductID
WHERE p.Color = 'Black'

SELECT * 
FROM Production.Product p 
WHERE p.Color = 'aaaaaaa'

--1--
SELECT * FROM Sales.SalesOrderDetail 

WHERE ProductID = 870

UNION ALL

SELECT * FROM Sales.SalesOrderDetail 

WHERE ProductID = 897;

SELECT * FROM Sales.SalesOrderDetail 

WHERE ProductID = 897 OR ProductID = 898;

