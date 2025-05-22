SELECT jc.Resume FROM
HumanResources.JobCandidate jc
INNER JOIN HumanResources.Employee e
    on jc.BusinessEntityID =e.BusinessEntityID
ORDER BY e.BusinessEntityID,jc.JobCandidateID

SELECT JobCandidateID
FROM HumanResources.JobCandidate jc
INNER JOIN HumanResources.Employee e
    on jc.BusinessEntityID =e.BusinessEntityID
ORDER BY e.BusinessEntityID,jc.JobCandidateID

/*
En la primer query, accede a HumanResources.JobCandidate a traves del clustered index
ya que necesita el campo Resume que no forma parte de ningun indice.

Como los campos se quieren ordenados primero por e.BusinessEntityID y segundo por jc.JobCandidateID
decide ordenar el result set de dicha tabla. Accede a HumanResources.Employee por indice clustered
ya que le conviene porque lo necesita ordenado por la PK
Y como son pocos campos en ambos result set, termina realizando un nested loop.

A diferencia de la segunda query, accede a la tabla HumanResources.JobCandidate por el indice
BusinessEntityID ya que es mas chico y encima esta ordenado primero por ese valor. A su vez,
va a contener el JobCandidateID ya que es la PK por lo que formara parte del indice.

Accede a HumanResources.Employee por indice clustered ya que le conviene porque lo necesita ordenado por la PK,
luego ambas tablas tendran el orden necesario y como ambos result set, termina realizando la junta por un nested loop.
*/