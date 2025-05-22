SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43683 AND SalesOrderDetailID = 240;


SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43683 OR SalesOrderDetailID = 240

/*
PK: <SalesOrderID ; SalesOrderDetailID>

Para la primer query accede directamente al indice clustered pues en el WHERE se estan filtrando dos
valores que forman parte de dicha PK (por ello hace un seek)

Mientras que para la segunda query, se buscan valores del estilo:
    * _ ; 240
    * 43683; _
    * 43683; 240

Es decir, que si tuviese que acceder por el indice clustered para las keys: _;240 seria muy costoso,
Por ello, accede al indice unclustered mas chico: por ProductId, en dicho indice viviran ambas partes de la PK, por lo
cual, puede acceder a dicho indice y luego filtra a aquellas que tengan: SalesOrderID = 43683 OR SalesOrderDetailID = 240
*/