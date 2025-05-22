SELECT P.Name , P.ProductNumber
FROM Production.Product P
WHERE ProductNumber ='EC-R098';

SELECT P.ProductID , P.ProductNumber
FROM Production.Product P
WHERE ProductNumber ='EC-R098';

/**

Tanto en la primer query como en la segunda, acceden por un indice unclustered de la tabla: ProductNumber.
Para el caso de la segunda query, como el indice unclustered tiene toda la informacion necesaria solicitada
en el select: El ProductNumber (forma parte del indice) y el ProductId: PK, no es necesario realizar un key-lookup,
por lo que termina en este punto.

Mientras que en la primer query, el indice unclustered no contiene toda la informacion, en este caso el Name,
por lo que realiza un key-lookup usando el clustered y asi traerse el Name. Es decir, realiza dos lecturas: primero
sobre el indice para resolver el where y despues usa el operador key-lookup para traese el Name.
**/

