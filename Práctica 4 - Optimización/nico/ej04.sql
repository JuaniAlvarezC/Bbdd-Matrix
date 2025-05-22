SELECT ProductID, PV.BusinessEntityID, Name
FROM Purchasing.ProductVendor PPV JOIN Purchasing.Vendor PV
ON (PPV.BusinessEntityID =PV.BusinessEntityID);

SELECT ProductID, PV.BusinessEntityID, Name
FROM Purchasing.ProductVendor PPV JOIN Purchasing.Vendor PV
ON (PPV.BusinessEntityID =PV.BusinessEntityID)
WHERE StandardPrice > $10;

SELECT ProductID, PV.BusinessEntityID, Name
FROM Purchasing.ProductVendor PPV JOIN Purchasing.Vendor PV
ON (PPV.BusinessEntityID =PV.BusinessEntityID)
WHERE StandardPrice > $10 AND Name LIKE N'F%';

/*
En la primer query, hace un merge join, ya que aprovecha el hecho de que
los campos por el cual se esta uniendo estan ordenados, pues BusinessEntityID
forma parte de la PK en Purchasing.ProductVendor y es la PK de Purchasing.Vendor

A su vez, en la tabla Purchasing.ProductVendor, aprovecha del indice BusinessEntityID, que
es mucho mas chico que el clustered index y contiene solo el campo que utiliza para hacer la junta con
Purchasing.Vendor.

Ademas en Purchasing.Vendor no le queda otra que acceder por el indice clustered ya que necesita
devolver el campo Name y no hay indice que lo contenga.

Por otro lado, en la segunda query, accede a ambas tablas de la junta por el indice clustered, ya que
ahora si de la tabla Purchasing.ProductVendor necesita el StandardPrice, por lo que ya no puede acceder mas por el indice
anterior. A su vez, como necesita filtrar por ese campo, no le queda otra que hacer una tabla de hash para poder
filtrar esos valores que no se encuentran ordenados por dicho campo.

Por ultimo, en la ultima query, accede a Purchasing.ProductVendor aprovechando del indice BusinessEntityID
para realizar la junta con Purchasing.Vendor. En esta primer junta, se filtran los campos que
tengan Name LIKE N'F%'. Luego del resultado obtenido, se hace un key lookup en la tabla Purchasing.ProductVendor
para filtrar a aquellos que tengan StandardPrice > 10.
*/