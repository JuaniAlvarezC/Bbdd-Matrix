###Ejercicio 1 

En el primer caso, name tiene un índice unclustered, y departmentID es la primary key, así que resulta más rápido buscar los datos directamente en
el índice unclustered, porque la tabla tiene menos tamaño al no tener todas las filas.
En el segundo caso se agrega groupName. No hay índice clustered que contenga a los tres campos así que es necesario buscar todo en el clustered.

###Ejercicio 2
El primer caso tiene una condición where, que el motor puede resolver sencillamente mientras hace el scan de los datos. Al haber un group by, como 
los datos no están ordenados por unitPrice, pero el optimizador estima que se armarán pocos grupos, se utiliza un hash match. Luego computar el
promedio de los datos por grupo se resuelve de manera inmediata.

La situación del segundo caso es similar pero ya no hay where, sino having. Esto requiere filtrar los datos que cumplan con la condición requerida.

###Ejercicio 3 
En el primer caso no hay nonclustered index con p.Color, así que solo se hace un scan en el clustered index de product y se toman los que cumplan.

En el segundo, sin embargo, sí hay nonclustered index para product number, y además el optimizador estima que hay pocos elementos que cumplan la condición
(efectivamente se devuelve uno solo, es único) Al estar indexado por product number y ser pequeño, es óptimo para un nested loop join, donde va a buscar
el nombre de cada producto mediante el product id.

###Ejercicio 4
En la primera query, similar al caso dos del ejercicio anterior, el optimizador estima que hay pocos transactionHistory con ese referenceOrderId, y 
además este campo tiene nonclustered index, así que decide que es mejor buscarlos a todos y después obtener el resto de los datos usando nested loop 
join y keep lookup. Para el join, este resultado es usado como inner loop al ser pequeño. Los valores de product pedidos no tienen nonclustered index
así que deben ser obtenidos mediante clustered index scan.

El segundo caso empieza igual pero el resultado del primer join es de cardinalidad mayor, así que se resuelve que es más rápido hacer merge join. Al
ser join por productId, como product ya está ordenado, solamente se ordenan las tuplas de transactionHistory, que no son tantas.

###Ejercicio 5
En el primer caso no hay nonclustered index con productID y actualCost entonces los datos no están ordenados por product_id al no ser la clave 
primaria en el clustered index, así que para hacer group y luego sacar el promedio, se resuelve utilizar un hash. 

En el segundo caso, en vez de average se pide count. Actual cost no puede ser null así que la cuenta equivale a la cantidad de elementos en la tabla.
Product id tampoco es null, así que sus cardinalidades son iguales.
Para resolver la consulta, el optimizador aprovecha el nonclustered index de product id para hacer un index scan. Como los datos están ordenados,
se puede contar mediante stream aggregate, que es más rápido.

###Ejercicio 6
En el primer caso se usa información de las tres tablas: person y personphone en el select, phoneNumberType en el where. No queda otra que buscarlas
todas. Los datos buscados de person y la primary key necesaria para el join están todos en un nonclustered index, así que se puede buscar
directamente de allí al ser más rápido. Al buscarse solo ciertos datos, el resultado es pequeño y está indexado. De person phone se busca todo
al no haber nonclustered index que cumpla lo pedido. Queda indexado por businessEntityID, por lo que ambas tablas pueden hacer nested loop join.
Al ser el resultado pequeño, se puede hacer otro nested loop join con la búsqueda de phone number type. Para que éste esté indexado por 
phoneNumberTypeID, que es la condición del join, y quizás porque no hay nonclustered index con phone number type, es buscado con clustered index
scan. El resultado se junta mediante nested loop join.

En el segundo caso no se pide nada phoneNumberType. Además la condición de join es sobre el foreign key de personPhone, phoneNumberTypeID. 
Y no puede ser null. Aprovechando la integridad referencial, el motor sabe que todo valor en personPhone se corresponde con uno en phoneNumberType.
Por lo tanto no necesita hacer un join con hacer tabla. Simplemente junta las otras dos de la misma forma que lo había hecho antes

