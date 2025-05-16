SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 58950;
/*
Dado que SalesOrderID es la PK y es un clustered index, directamente busca en el índice clustered los registros que pueden cumplir con la condición del where, notar que busca directamente esos valores, no necesita hacer un full scan. Una vez que encuentra el registro, devuelve los campos requeridos.
*/

SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderDetailID = 68531;
/*
Dado que SalesOrderDetailID es un unclustered index non unique, debe hacer un escaneo completo de la tabla para encontrar todos los registros que cumplan con la condición. Usa ProductID para recorrer toda la tabla y seleccionar los valores que cumplen el where
*/