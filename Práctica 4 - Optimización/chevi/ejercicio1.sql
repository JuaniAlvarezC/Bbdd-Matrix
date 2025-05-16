-- Ejercicio 1

SELECT P.Name , P.ProductNumber
FROM Production.Product P
WHERE ProductNumber ='EC-R098';
/*
Primero usa ProductNumber que es un unclustered index para filtrar y seleccionar solamente las filas que cumplen la condición del where. Luego busca en la tabla usando el clustered index ProductID los registros asociados a las filas seleccionadas para recuperar el Name
*/

SELECT P.ProductID , P.ProductNumber
FROM Production.Product P
WHERE ProductNumber ='EC-R098';
/*
Dado que los unclustered index contienen el clustered index de la tabla dentro de la estructura, directamente hace un Index Seek sobre el unclustered index ProductNumber, filtra usando la cláusula del where y devuelve directamente los valores de ProductNumber y ProductID, como se requería
*/