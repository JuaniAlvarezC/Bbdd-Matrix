SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43683 AND SalesOrderDetailID = 240;
/*
Puesto que el índice clustered de la tabla está compuesto por los dos campos que se requieren directamente se hace un clustered index scan para encontar si existe el registro asociado a ese índice 
*/

SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43683 OR SalesOrderDetailID = 240;
/*
Dado que es un OR, no puede usar directamente un seek en el índice clustered por lo que recorre toda la tabla utilizando ProductID, aunque no tengo idea de por qué.
*/