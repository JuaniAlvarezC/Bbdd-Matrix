SELECT jc.Resume FROM HumanResources.JobCandidate jc
INNER JOIN HumanResources.Employee e on jc.BusinessEntityID =e.BusinessEntityID
ORDER BY e.BusinessEntityID,jc.JobCandidateID;
/*

*/

SELECT JobCandidateID FROM HumanResources.JobCandidate jc
INNER JOIN HumanResources.Employee e on jc.BusinessEntityID =e.BusinessEntityID
ORDER BY e.BusinessEntityID,jc.JobCandidateID;
/*

*/