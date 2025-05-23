SELECT i.name, i.type_desc, i.is_unique FROM sys.indexes i
WHERE 
  i.object_id = OBJECT_ID('HumanResources.JobCandidate');    