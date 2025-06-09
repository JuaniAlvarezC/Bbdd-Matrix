### 1.1. Describa brevemente limitaciones de las base de datos relacionales y con qu´e caracter´ısticas las base de datos NoSql mitigan este problema.

Las principales limitaciones de las bases de datos SQL son la velocidad y la incapacidad de manejar datos semiestrucurados. Cuando se cuenta con muchos datos los motores de bases SQL pueden ser bastante lentos y cuando los datos no tienen una estructura rígida puede no ser ideal usar SQL. El otro punto en contra es que es más dificil escalarlas en forma horizontal, en general se requiere un servidor con más poder de cómputo en lugar de más servidores.

Es por esto que las bases de datos No SQL están pensadas para tener más flexibilidad y escalabilidad, aunque a costa de consistencia muchas veces. Son más tolerantes a fallos y veloces.

### 1.2. Describa los cuatro tipos de base de datos NoSql.

Los cuatro tipos son:
- Graph database: los datos se guardan en forma de objetos con ejes entre ellos. Forman un grafo y se los puede operar con operaciones sobre grafos. Un ejemplo de este modelo es ArangoDB
- Key-Value: Son bases de datos muy sencillas que únicamente guardan pares de datos clave-valor en forma muy eficiente y muchas veces no utilizan memoria secundaria. Son ideales para implementar caches o sistemas de autenticación por tokens en páginas web. Están pensadas para almacenar información temporal en forma muy rápida de acceder. Un ejemplo es Redis
- Document: Guardan documentos en colecciones. Los docuemntos típicamente son JSON o XML. Permiten guardar información semiestructurada y responder algunas consultas sencillas en forma nativa. Un ejemplo es MongoDB
- Column: Permite almacenar datos en forma ordenada que serán consultados en su totalidad por clave. Posee una clave que identifica unívocamente la parte de los datos que se quiere y una o más claves que agrupan los datos en grupos. Está pensada para muchos datos en forma descentralizada y escalable. Cassandra es un ejemplo.

### 1.3. ¿Qu´e es un espacio de nombres o bucket en una base de datos Key-Value?

Un espacio de nombre es una forma de agrupar valores y claves relacionadas dentro de la base de datos para aislar los datos de aplicaciones distintas. También permite organizar en forma más prolija los datos.

### 1.4. ¿De ejemplos de uso de TTL (time to live) en una base Key-Value?

1. Un token que permite al usuario comprar entradas para algo durante un cierto tiempo hasta que expiren la sesión
2. Un cache con resultados costosos de computar para una página web pero que si se pierden no pasa nada, se recalculan
3. Información de una partida de un juego en curso en un servidor

### 1.5. Compare Key-Value con Document Database, de ventajas y desventajas de una u otra.

La ventaja de Key-Value es que permite almacenar cualquier tipo de dato de tal manera que su acceso es ultra rápido, aunque no está pensada para dar consistencia ni persistencia (redis por ejemplo). Además no tienen una estructura interna, garantías ni tampoco permiten hacer consultas más alla de buscar una clave. 

Por otra parte, una base de datos de documentos presupone que se está tratando con datos que son importantes y se quieren guardar y son semiestructurados. Permiten consultas complejas sobre los datos y los guardan con una cierta estructura. A cambio pueden ser un poco más pesadas y lentas para ciertas operaciones.

### 1.6. Discuta ventajas y desventajas de que una Document Database sea schemaless.

Una Document Database schemaless (sin esquema fijo) permite almacenar documentos con estructuras diferentes dentro de una misma colección. Esto tiene ventajas y desventajas que dependen del contexto de uso:

✅ Ventajas
Flexibilidad:
Puedes agregar, quitar o modificar campos en los documentos sin alterar un esquema global. Esto facilita el desarrollo ágil y la evolución del modelo de datos.

Desarrollo rápido:
Ideal para proyectos donde los requerimientos cambian con frecuencia, como prototipos o MVPs.

Adaptación a datos heterogéneos:
Soporta fácilmente datos de diferentes formas (por ejemplo, distintos tipos de usuarios o productos en un mismo sistema).

Menor rigidez:
Evita errores causados por migraciones de esquema o por tener que mantener sincronizados esquemas complejos.

❌ Desventajas
Falta de validación estructural:
Si no se controla desde la aplicación, pueden almacenarse documentos incompletos, inconsistentes o con errores de formato.

Mayor complejidad en las consultas:
Consultar datos se vuelve más difícil si los documentos no tienen una estructura común (por ejemplo, un campo puede existir en algunos documentos y en otros no).

Difícil mantenimiento:
A largo plazo, mantener datos con múltiples formas puede generar confusión y aumentar el riesgo de bugs.

Problemas de rendimiento:
Si los documentos tienen estructuras muy variables, los índices y el motor de búsqueda pueden ser menos eficientes.


### 1.7. ¿En qu´e casos puede ser conveniente desnormalizar?

Puede ser conveniente desnormalizar cuando se quiere acceder a datos adicionales al consultar por un objeto. Por ejemplo, si se consulta una dirección y la provincia está normalizada, habrá que hacer una segunda consulta para encontrar esa provincia que si los datos estuviesen desnormalizados, no haría falta. Para bases de datos documentales, esta segunda consulta puede ser costosa (o más costosa de lo que sería en una base de datos relacional) y por lo tanto puede tener sentido agregar redundancia para ganar velocidad en consultas que se hacen frecuentemente.

### 1.8. Compare las Column Family Databases con otros tipos de bases de datos NoSQL.
Las Column Family Databases (también llamadas bases de datos orientadas a columnas) son un tipo de base de datos NoSQL diseñadas para manejar grandes volúmenes de datos distribuidos de manera eficiente, especialmente en operaciones de lectura masiva. A continuación, se comparan con los otros tres tipos principales de bases de datos NoSQL:

📊 Column Family Databases
(Ej.: Apache Cassandra, HBase)

Modelo: Los datos se almacenan por columnas agrupadas en "familias de columnas", lo que permite acceder rápidamente a ciertas columnas sin leer toda la fila.

Ventajas:

Excelente rendimiento en consultas analíticas.

Muy escalables y distribuidas por diseño.

Buenas para datos estructurados y consultas con rangos o filtros por columnas.

Desventajas:

Modelo de datos más complejo que otras NoSQL.

No son ideales para datos muy irregulares o no estructurados.

Casos de uso: sistemas de monitoreo, análisis de logs, sistemas de recomendación.

🔑 Key-Value Stores
(Ej.: Redis, DynamoDB)

Modelo: Pares simples de clave → valor, sin estructura interna entendible por la base.

Comparación:

Más simples y rápidos para accesos directos.

Menos potentes en consultas complejas o analíticas.

No permiten consultar por atributos dentro del valor.

📄 Document Databases
(Ej.: MongoDB, CouchDB)

Modelo: Documentos (JSON/BSON) con campos y estructura jerárquica.

Comparación:

Más flexibles y expresivos para datos semiestructurados.

Mejor soporte para consultas por campo.

Menos eficientes que Columnar DB en cargas analíticas grandes.

🔗 Graph Databases
(Ej.: Neo4j, Amazon Neptune)

Modelo: Nodos y relaciones (grafos), ideales para representar conexiones entre entidades.

Comparación:

Superiores para consultar relaciones complejas (como redes sociales, rutas).

No tan buenas para cargas analíticas o lectura de grandes cantidades de datos planos.
| Característica      | Column Family       | Key-Value             | Document                   | Graph                   |
| ------------------- | ------------------- | --------------------- | -------------------------- | ----------------------- |
| Modelo              | Columnas agrupadas  | Clave → Valor         | Documentos JSON            | Nodos y relaciones      |
| Flexibilidad        | Media               | Alta (sin estructura) | Alta (estructura flexible) | Alta en relaciones      |
| Consultas complejas | Buena en analíticas | Solo por clave        | Buena por campos           | Excelente en relaciones |
| Escalabilidad       | Muy alta            | Muy alta              | Alta                       | Alta, pero más compleja |
| Casos ideales       | Big data, logs      | Caché, sesiones       | APIs, perfiles             | Recomendaciones, redes  |

### 1.9. ¿A que se denomina consistencia eventual?

Se denomina consistencia eventual a una base de datos que no garantiza una consistencia estricta sino que permite que a medida que pase el tiempo las escrituras eventualmente sean vistas por el resto de los usuarios. Es posible que al pedir un valor, se vea una versión vieja (o no) pero lo que garantiza el sistema es que si se espera el tiempo suficiente, eventualmente se verá la versión más reciente. En un equilibrio, siempre se verñia la versión más nueva.

### 1.10. Explique el teorema CAP.

Las siglas quieren decir:

- C: Consistencia, todos ven los mismos datos a la vez
- A: Disponibilidad, si te podés comunicar con el cluster, podés escribir y leer de él
- P: Tolerancia a particiones, si la red se parte en más de un pedazo y estos pedazos no se pueden comunicar entre sí, el sistema puede sobrevivir funcionando.

El teorema establece que no se puede tener las tres cosas a la vez, a lo sumo dos. Es interesante que se puede sacrificar en forma parcial alguna para ganar en otras, no es necesariamente por sí o no.