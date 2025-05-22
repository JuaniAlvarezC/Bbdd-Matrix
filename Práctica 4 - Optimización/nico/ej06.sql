SELECT count(NameStyle) FROM Person.Person

SELECT count(Title) FROM Person.Person

/*
En la primer query, dado que se encuentra contando campos que no admiten nulos (NameStyle),
en vez de ir a buscarlo al clustered index que es mucho mas grande, aprovecha y cuenta cuantos
rowguid hay, dicho campo no es nulo tampoco, por lo que ambos resultados van a ser iguales.
A su vez, se aprovecha de dicho campo ya que hay un indice y sera mucho mas liviano accederlo.

En la segunda query, como cuenta campos que pueden nulos, ya no hay indice que se pueda aprovechar
por lo que no le queda otra que contar por el indice clustered.
*/