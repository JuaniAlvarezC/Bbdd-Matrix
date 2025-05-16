SELECT ProductID, PV.BusinessEntityID, Name
FROM Purchasing.ProductVendor PPV JOIN Purchasing.Vendor PV
ON (PPV.BusinessEntityID =PV.BusinessEntityID);
/*
Dado que tiene un índice clustered para BuisnessEntityID ordenado y un índice non unique unclustered para BuissnessEntityID pero también ordenado, puede simplemente ir leyendo en órden y haciendo un merge, a la vez que obtiene el Name dado que esta en los registros del índice principal de PV. Dado que el clustered index de PPV es ProductID - BuisnessEntityID, el ProductID lo obtiene directamente de lo que esta guardao en el índice IX que recorre.
*/

SELECT ProductID, PV.BusinessEntityID, Name
FROM Purchasing.ProductVendor PPV JOIN Purchasing.Vendor PV
ON (PPV.BusinessEntityID =PV.BusinessEntityID)
WHERE StandardPrice > $10;
/*
Utiliza los clustered indexes de ambas tablas, dado que hace un scan, mientras lo hace va filtrando los valores de acuerdo al where. Usa un Hash Match puesto que el index de PPV no está ordenado por BuisnessEntityID sino en primer lugar por ProductID, por lo que no puede hacer un merge.
*/

SELECT ProductID, PV.BusinessEntityID, Name
FROM Purchasing.ProductVendor PPV JOIN Purchasing.Vendor PV
ON (PPV.BusinessEntityID =PV.BusinessEntityID)
WHERE StandardPrice > $10 AND Name LIKE N'F%';
/*
Primero filtra por el Name recorriendo toda la tabla PV usando el clustered index, dado que quedan pocos valores este es el outer del nested loop; luego se hace el join usando unclustered nin unique BuisnessEntityID de PPV como inner para hacer el join entre PV y PPV. Luego se hace otro nested loops usando el join como outer y se hace un key lookup de cada uno de esos valores en PPV para verificar que el StandardPrice > $10
*/