SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 58950;

SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderDetailID = 68531;



/*

SalesOrderID y SalesOrderDetailID son PK compuesta: <SalesOrderID ; SalesOrderDetailID>

Como la primer query accede por la primer parte de la primary key, realiza directamente una busqueda
clustered seek devolviendo los valores que forman parte del indice, es decir, va filtrando por la primer
parte de la key.

Para el caso de la segunda query, esta accediendo por la parte dos de la PK compuesta: < _ ; SalesOrderDetailID>

Por lo que decide realizar una busqueda por uno de los indices unclustered mas chicos de la misma: ProductId,
decide utilizar este indice, ya que la informacion solicitada en el select es informacion que forma parte del indice
ProductId (unclustered) -- son los dos campos de la PK y ademas este indice es mas chico que acceder por uno clustered.

*/