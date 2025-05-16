SELECT P.Name, PSC.Name SubCatrom
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON p.ProductSubcategoryID = psc.ProductSubcategoryID;
/*
Para hacer el join se utiliza un Hash Match puesto que decide usar de PSC el unique unclustered index Name que contiene valores que pueden ser devueltos. Como además va a contener el clustered index de la tabla que resulta ser ProductSubcategoryID, ya tiene todo lo necesario de esa tabla para responder la consulta operando con registros más pequeños. Es entonces que pasa a hacer un scan sobre el Clustered Index de P para obtener los Name de los registros asociados a los de PSC.
*/

SELECT P.Name, PSC.Name SubCatrom
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
ORDER BY psc.ProductSubcategoryID;
/*
La consulta es igual a la anterior pero se solicita que los resultados estén ordenados de acuerdo a ProductSubcategoryID. En este caso decide recorrer PSC usando el clustered index puesto que de este modo ya obtiene los valores requeridos ordenados de la forma pedida y luego obtiene los registros de P mediante un clustered scan y los ordena por el campo requerido. Finalmente, al tener ambas tablas ordenadas por ProductSubcategoryID hace simplemente un Merge Join y proyecta los campos Name de ambas tablas
*/