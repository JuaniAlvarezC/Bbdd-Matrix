###Ejercicio 1 
En el primer caso se hace left join desde productReview. El optimizador sabe que éste tiene una cardinalidad pequeña así que es óptimo para inner loop
join. Para buscar los elementos del inner loop decide hacer un clustered index scan, quizás porque necesita todos los elementos. Para obtener los del
outer loop también, porque deben estar indexados por productId.

En el segundo es un right join. Product tiene cardinalidad mayor así que se decide tomar otro método: merge join. Esto requiere que ambas tablas
estén ordenadas por productId. En el caso de product es fácil porque es primary key, solo requiere un clustered index scan. En productReview no. Se
podría ordenar, pero en vez de eso se busca aprovecha el nonclustered index productId que tiene éste y se junta con el resto de los datos mediante
nested loop join. Al buscar desde el nonclustered index, estará ordenado como se quería.

###Ejercicio 2
En el primer caso se hace un esperable scan por el clustered index, devolviendo todos los elementos que cumplan con la condición esperada.
En el segundo, el optimizador estima que hay pocas tuplas que cumplan la condición, y tiene además un nonclustered index sobre productId. Además
es una condición SARGable. Entonces resuelve buscar directamente en el nonclustered index y luego, dado que el resultado es pequeño, buscar el resto
de los datos aprovechando la clave principal en el nonclustered index mediante index seek. Esto conlleva un nested loop join.

###Ejercicio 3
En el primer caso hay un join sin condición de igualdad. No queda otra que usar nested loop join. El optimizador estima que businessEntityAdress 
tiene cardinalidad menor así que lo usa como inner loop. Como se quiere todo, debe hacerse un scan del clustered index. Al ser la condición de join
el businessEntityId, que es la primary key de businessEntity, si se hace clustered index scan de esta tabla, ya estará indexado. Así se arma el nested
loop join.

En el segundo caso el join es por igualdad, y ambas tablas tienen como primera clave primaria a businessEntityId. Por lo tanto si se hace un 
clustered index scan de cada uno, quedarán ordenados por esta clave. Es óptimo para un merge join.

###Ejercicio 4
En el primer caso se tiene una restricción sobre el apellido, que es SARGable. Además este tiene un nonclustered index. Sin embargo se pide
person.title, que no está en ese index. El optimizador decide que lo más rápido es buscar en el nonclustered index, dado que habrá pocos
resultados, y luego hacer un nested loop join con key lookup para obtener cada titulo.

En el segundo caso la restricción es sobre businessEntityId, la clave primaria. Es mucho más fácil hacer toda la búsqueda en el clustered index
directamente.

###Ejercicio 5
En el primer caso no se tiene nonclustered index con person id, así que para obtener los datos se debe buscar por clustered index. PersonId no es
clave principal así que los datos no están ordenados por este. El optimizador resuelve que es más rápido utilizar agregación por Hash match que 
ordenar y hacer stream aggregate.

En el segundo caso sí se tiene nonclustered index. Entonces es posible obtener los datos ordenados directamente de allí. Como están ordenados
se puede usar mejor el stream aggregate, que es más rápido.