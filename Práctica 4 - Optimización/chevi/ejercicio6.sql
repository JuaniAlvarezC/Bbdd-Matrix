SELECT count(NameStyle) FROM Person.Person;
/*
Dado que la columna rowguid no es nullable, al igual que NameStyle, aprovecha que rowguid es un unclustered unique index y por lo tanto cuenta directamente la cantidad de entradas en ese índice en lugar de hacer un scan de toda la tabla.
*/

SELECT count(Title) FROM Person.Person;
/*
Puesto que title es nullable, se ve forzado a hacer un full scan de toda la tabla usando el clustered index para contar solo los registros en los que title no sea null.
*/