SELECT i.name, i.type_desc, i.is_unique FROM sys.indexes i
WHERE 
  i.object_id = OBJECT_ID('HumanResources.JobCandidate');    

SELECT *
FROM Purchasing.ShipMethod
ORDER BY Name

SELECT *
FROM Purchasing.ShipMethod
WHERE Name IS NOT null

SELECT CardType
FROM Sales.CreditCard
GROUP BY CardType

SELECT CardNumber
FROM Sales.CreditCard
GROUP BY CardNumber

--3--
SELECT *
FROM sales.SalesOrderDetail
WHERE UnitPrice > ALL (
  SELECT UnitPrice 
  FROM Sales.SalesOrderDetail
  WHERE OrderQty >12
)

SELECT *
FROM sales.SalesOrderDetail
WHERE UnitPrice > (
SELECT MAX(UnitPrice)
FROM Sales.SalesOrderDetail
WHERE OrderQty >12
)