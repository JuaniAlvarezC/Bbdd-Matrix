SELECT P.Name, PSC.Name SubCatrom
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON p.ProductSubcategoryID = psc.ProductSubcategoryID

SELECT P.Name, PSC.Name SubCatrom
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
ORDER BY psc.ProductSubcategoryID

/*
En la primer query accede a Production.ProductSubcategory por el indice Name,
ya que se pide de dicha tabla el Name y la PK forma parte de este indice.

Luego como de la tabla Product necesita tanto el Name como el ProductSubcategoryID,
y no hay indice que le sirva, no le queda otra que acceder por el indice clustered.
Luego, como los campos no estan ordenados, realiza un hash match.

Por otro lado, en la segunda query, como se necesita ordenado por ProductSubcategoryID
le conviene acceder al clustered index de Production.ProductSubcategory que ya va a estar
ordenado por dicho campo por ser la PK. Ademas, ya que se pide ordenado por ese campo,
al resultado de la tabla Production.Product, la ordena por ProductSubcategoryID para poder
realizar un merge join, aprovechando que ambos resultset van a estar ordenados.
*/