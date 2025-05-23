### Ejercicio 1

El (a) realiza un **Nonclustered Index Seek** sobre *AK_Employee_NationalIDNumber* con lo cual obtiene la primary key,\
(`BusinessEntityID`)  ya que esta está asocida a todos los índices. Sin embargo, en la consulta se pide\
la `HireDate`, con lo cual debe realizar un **Key Lookup** sobre *PK_Employee_BusinessEntityID*. Luego realiza\
un **Nested Loops** para unir la `HireDate` con el `NationalIDNumber`.

El (b) realiza unicamente un **Nonclustered Index Seek** sobre *AK_Employee_NationalIDNumber* ya que la consulta solo\
requiere de `NationalIDNumber` y `BusinessEntityID`, la cual está incluida en el índice.

### Ejercicio 2

El (a) realiza un **Nonclustered Index Seek** sobre *IX_Address_StateProvinceID* obteniendo `StateProvinceId` y\
`AddressId`. Luego un **Key Lookup** sobre *PK_Address_AddressId* para obtener los campos restantes. Para unir\
todos los datos hace un **Nested Loops** ya que sabe que son pocos los datos que tendrá que unir.

El (b) por otro lado, realiza un **Clustered Index Scan**

La diferencia entre estas consultas radica en las estadísticas previas del motor de búsqueda. A través de las\
consultas, el motor gaurda información para eficientizar búsquedas futuras. Por este motivo, podemos ver que\
en (a), el motor sabe que encontrará pocos elementos y puede hacer un **Index Seek** y un **key look up**. Mientras que en\
(b) sabe que traerá muchas filas y hacer el mismo procedimineto es más costoso que un **Clustered Index Scan**.

### Ejercicio 3

En (a) tenemos un **Unclustered Index Seek** sobre *IX_Person_LastName_FirstName_MiddleName* aprovechandose de que\
el WHERE es por `LastName` y este índice está ordenado por el mismo. Luego un **Key Lookup** sobre *PX_Person_BusinessEntityID*.\
En este último se obtiene el `NameStyle` mientras que en el primero se obtienen los demás.\
Para finalizar, como son pocas filas, hace un **Nested Loops**.

En (b) no puede realizar lo mismo, ya que el WHERE es por `FirstName` con lo cual realiza un **Unclustered Index Scan**\
y luego como el anterior, un **Key Lookup** para obtener la columna restante. Al final, también hace un **Nested Loops**.

En (c) como el WHERE de la consulta es sobre si `MiddleName` es NULL (el cual es un atributo nulleable) debe consutlar\
todas las filas, con lo cual, realiza un **Clustured Index Scan** sobre *PK_Person_BusinessEntityID*

### Ejercicio 4

En (a) se realiza un **Nonclustered Index Seek** sobre *AK_Departement_Name* para obtener `DepartementId` y `Name`.\
Luego, como la consulta también requiere de la columna `GroupName` y son pocos tablas las que obtuvo en el seek realiz aun **Key Lookup**.\
Para finalizar hace un **Nested Loops** para unir las columnas.

En (b), por otro lado, debe hacer un **Clusutured Index Scan** sobre *PK_Departement_DepartementID* ya que el WHERE contiene un '%' con lo cual,\
el estimador de cardinalidad estima que la canitdad de filas que pueden contenerlo va a ser más grande que la de la consulta (a). Por lo tanto,\
es menos costos realiza un scan en lugar de seek + key lookup.

### Ejercicio 5

La consulta comienza con un **Clustered Index Scan** sobre *PK_Store_BusinessEntityID*, luego ordena la ordena por `Name`.\
Luego hace un **Clustered Index Seek** sobre *PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID* y finaliza con\
un **Nested Loop** para juntar los resultados.

Para evitar el sort, podemos generar un **Nonclustered index** *IX_Sales_Name* sobre la columna `Name`, con lo cual, ahora solo\
debería recorrer este indice, el cual ya está ordenado por nombre, y luego realizar el index seek y el nested loop. 

### Ejercicio 6

En (a) se realiza un **Index Scan** sobre *IX_ProductVendro_BusinessEntityID* y sobre *AK_Prodcut_Name* y un **Hash Match** para unirlos.\
Luego realiza un **Clustered Index Scan** sobre *PK_Vendor_BusinessEntityID* y un **Hash Match** para unir los resultados unidos previamente\
con el nuevo scan.

En (b) por otro lado realiza un **Clustered Index Seek** sobre *PK_ProductVendor_BusinessEntityID* y *PK_ProductVendor_ProductID* uniendolos con\
**Nested loop**. Luego al igual que en (a) realiza un seek pero realiza otro **Nested Loop** para unir los resultados.

La diferencia de estas consiutlas radica en que (b) tiene un WHERE donde el estimador sabe que va a filtrar muchos resultados y por ende\
le es menos costos realizar seeks y nested loops. Mientras que en (a), al no tener WHERE, se van a traer todas las filas posibles que\
respeten el JOIN, por lo tanto hacer seeks no conviene y menos nested loops. Por estos motivos, realiza Index Scan sobre otro índices y\
Hash Match para unirlo, el cual se usa para grandes cantidades de datos.