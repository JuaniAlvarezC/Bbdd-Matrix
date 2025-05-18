Antes de cada ejercicio uso esta consulta para ver los índices de la tabla
```SQL
SELECT i.name AS IndexName, i.type_desc AS IndexType
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id 
WHERE t.name = 'COMPLETAR CON NOMBRE DE TABLA'
```

### Ejecicio 1

|IndexName|IndexName|
| - | -|
| PK_Product_ProductID | CLUSTERED |
| AK_Product_ProductNumber | NONCLUSTERED |
| AK_Product_Name | NONCLUSTERED |
| AK_Product_rowguid| NONCLUSTERED |


```SQL
SELECT P.Name , P.ProductNumber
FROM Production.Product P
WHERE ProductNumber ='EC-R098'
```
Primero hace un index seek por `ProductNumber` y después un key look up por `PrductId` para encontrar el nombre. 
Luego hace aplica `Nested Loops` para combinar resultados

```SQL
SELECT P.ProductID , P.ProductNumber
FROM Production.Product P
WHERE ProductNumber ='EC-R098'
```
Hace únicamente un Index Seek por `PorductNumber` como no se pide el nombre entonces no hace falta ir a buscar a los registros.

---
### Ejercicio 2

|IndexName|IndexName|
| - | -|
| PK_SaleOrdersDetail_SalesOrderID_SalesOrderDetailID | CLUSTERED |
| AK_SalesOrderDetail_rowguid | NONCLUSTERED |
| AK_Product_Name | NONCLUSTERED |
| IK_SalesOrderDetail_ProductID| NONCLUSTERED |

```SQL
SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 58950
```
En este caso usa index seek con `SalesOrderId` sobre el índice clustered.

```SQL
SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderDetailID = 68531
```
Como no hay índice que empiecen con `SalesOrderDetailID`, con lo cual debe hacer un scan de toda la tabla, lo cual es menos eficiente.

---

### Ejercicio 3

```SQL
SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43683 AND SalesOrderDetailID = 240
```
Igual al ejercicio anterior, hace un index seek sobre *PK_SaleOrdersDetail_SalesOrderID_SalesOrderDetailID* 


```SQL
SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43683 OR SalesOrderDetailID = 240
```

En este caso, de vuelta tiene que hacer un scan ya que el espacio de soluciones es mucho más grande, 
mientras que en la anterior consulta había solo una respuesta, en esta no sabemos cuantas filas habrá.

---

### Ejercicio 4

|IndexName|IndexName|
| - | -|
|PK_ProductVendor_ProductID_BusinessEntityID| CLUSTURED |
|IX_ProductVendor_UnitMeasureCode| NONCLUSTURED |
|IX_ProductVendor_BuisnessEntityID| NONCLUSTURED |

|IndexName|IndexName|
| - | -|
|PK_Vendor_BusinessEntityID| CLUSTURED |
|IX_Vendor_AccountNumber| NONCLUSTURED |

```SQL
SELECT ProductID, PV.BusinessEntityID, Name
FROM Purchasing.ProductVendor PPV 
JOIN Purchasing.Vendor PV 
ON (PPV.BusinessEntityID = PV.BusinessEntityID)
```

Primero se hace un index scan sobre *PK_Vendor_BusinessEntityID* y luego otro index scan sobre *PK_ProductVendor_ProductID_BusinessEntityID*. Para finalizar, se hace un **merge join** ya que ambos estan ordenados por `BusinessEntityID`.

```SQL
SELECT ProductID, PV.BusinessEntityID, Name
FROM Purchasing.ProductVendor PPV 
JOIN Purchasing.Vendor PV
ON (PPV.BusinessEntityID = PV.BusinessEntityID)
WHERE StandardPrice > $10 
```

Como en el caso anterior, realiza un index scan sobre los mismos índices, sin embargo, 
realiza un **hash match** ya que no puede garantizar el orden debido al `WHERE`.

```SQL
SELECT ProductID, PV.BusinessEntityID, Name
FROM Purchasing.ProductVendor PPV JOIN Purchasing.Vendor PV
ON (PPV.BusinessEntityID = PV.BusinessEntityID)
WHERE StandardPrice > $10 AND Name LIKE N'F%'
```

Primero hace un index scan con `BusinessEntityID` sobre *PK_Vendor_BusinessEntityID*, 
como va buscar los Vendor que cumplan que el nombre comienza con una F, estima una baja cardinalidad, 
con lo cual hace un index seek sobre *IX_ProductVendor_BuisnessEntityID* y luego un *nested loops* para unir ambas tablas, 
que al tener pocos valores es más eficiente que hash match y merge join. 

Luego, un *key lookup* sobre *PK_ProductVendor_ProductID_BusinessEntityID* para buscar el `ProductID` y 
un último *nested loops* para unirlo con lo buscado anteriormente.

--- 

### Ejercicio 5

|IndexName|IndexName|
| - | -|
| PK_Product_ProductID | CLUSTERED |
| AK_Product_ProductNumber | NONCLUSTERED |
| AK_Product_Name | NONCLUSTERED |
| AK_Product_rowguid| NONCLUSTERED |

|IndexName|IndexName|
| - | -|
| PK_ProductSubcategory_ProductSubcategoryID | CLUSTERED |
| AK_ProductSubcategory_Name | NONCLUSTERED |
| AK_ProductSubcategory_rowguid | NONCLUSTERED |

```SQL
SELECT P.Name, PSC.Name SubCatrom
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
```

Primero hace un index scan sobre *AK_ProductSubcategory_Name* y otro sobre *PK_Product_ProductID*. 
Luego, como no estan ordenados porque el primer scan es sobre un NONCLUSTERED realiza un **hash match** para unir.

```SQL
SELECT P.Name, PSC.Name SubCatrom
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
ORDER BY psc.ProductSubcategoryID
```

En este caso hace un index scan sobre *PK_ProductSubcategory_ProductSubcategoryID* y 
otro sobre *PK_Product_ProductID*, **ordena** los resultados de este últmo scan por `ProductSubcategoryID` ya que el join se realiza sobre este campo.
Finaliza con un **merge join** ya que ambas tablas están ordenadas.

---
### Ejercicio 6

|IndexName|IndexName|
| - | -|
| PK_Person_BusinessEntityID | CLUSTERED |
| AK_Person_LastName_FirstName_MiddleName | NONCLUSTERED |
| AK_Person_rowguid | NONCLUSTERED |


```SQL
SELECT count(NameStyle) FROM Person.Person
```
Hace un index scan por *PK_Person_BusinessEntityID*, un stream aggregate y un compute scalar. 
En este caso `NameStyle` no puede ser null, con lo cual con contar los índices ya termina.

```SQL
SELECT count(Title) FROM Person.Person
```

Hace un index scan por *AK_Person_rowguid*, un stream aggregate y un compute scalar. 
El problema aca es que `Title` puede ser NULL, con lo cual debe traerse toda esa columna y chequear que no lo esa

---
### Ejercicio 7

|IndexName|IndexName|
| - | -|
| PK_JobCandidate_JobCandidateID | CLUSTERED |
| IK_JobCandidate_BusinessEntityID | NONCLUSTERED |

| IndexName                                     | IndexType    |
|----------------------------------------------|--------------|
| PK_Employee_BusinessEntityID                 | CLUSTERED    |
| IX_Employee_OrganizationNode                 | NONCLUSTERED |
| IX_Employee_OrganizationLevel_OrganizationNode | NONCLUSTERED |
| AK_Employee_LoginID                          | NONCLUSTERED |
| AK_Employee_NationalIDNumber                 | NONCLUSTERED |
| AK_Employee_rowguid                          | NONCLUSTERED |

```SQL
SELECT jc.Resume FROM HumanResources.JobCandidate jc
INNER JOIN HumanResources.Employee e 
ON jc.BusinessEntityID = e.BusinessEntityID
ORDER BY e.BusinessEntityID,jc.JobCandidateID
```

Primero realiza un index scan sobre *PK_JobCandidate_JobCandidateID* ya que necesita la tabla resume que no se encunetra en ninguna Key y lo ordena ya que el join se realiza sobre `BusinessEntityID`.
Luego realiza un index seek sobre *PK_Employee_BusinessEntityID*, y
para finalizar un nested loops para el join. Si el optimizador prefiere hace un seek por cada índice y después un nested loops significa que el conjunto de datos de JobCandidate es pequeño.

```SQL
SELECT JobCandidateID FROM HumanResources.JobCandidate jc
INNER JOIN HumanResources.Employee e 
ON jc.BusinessEntityID = e.BusinessEntityID
ORDER BY e.BusinessEntityID,jc.JobCandidateID
```
Primero realiza un index scan sobre *IK_JobCandidate_BusinessEntityID* ya que solo se pide el `JobCandidateID` y el join se hace sobre `BusinessEntityID`, con lo cual no hace falta traers todas las columnas.
Luego un seek sobre *PK_Employee_BusinessEntityID*.
Para unirlo usa un nested loops.