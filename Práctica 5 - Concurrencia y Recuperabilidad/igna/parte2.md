### Introducción a Protocolos de Bloqueo o Locking

2.1)

T1 = l1(A); r1(A); u1(A); l1(A); w1(A); u1(A); l1(B); r1(B); u1(B); l1(B); w1(B); u1(B);\
T2 = l2(A); r2(A); u2(A); l2(A); w2(A); u2(A); l2(B); r2(B); u2(B); l2(B); w2(B); u2(B);

Una historia no es serializable cuando su grafo de precedencia tiene un ciclo

H =  
l1(A); r1(A); u1(A);\
l2(B); r2(B); u2(B);\
l2(A); r2(A); u2(A);\
l1(A); w1(A); u1(A);\
l2(A); w2(A); u2(A);\
l1(B); r1(B); u1(B);\
l1(B); w1(B); u1(B);\
l2(B); w2(B); u2(B);

Grafo de precedecnia (mismo que el de locks):\
T1 -(A)-> T2\
T2 -(B)-> T1

Como hay un ciclo no es serializable y es legal ya que no hay lecturas ni escrituras que no tengan lock (? PREGUNTAR

2.2) PREGUNTAR

Si hacemos T1 y luego T2 entiendo que hay un dirt read ya que T2 escribe

|T|A|B|C|D|E|
|-|-|-|-|-|-|
1|A+2|||||
1|A+2|A+7||||
1|A+2|A+7|2C|||
2|A+3|A+7|2C|||
2|A+3|A+7|2C||A+11|
2|A+3|A+7|2C|D/5|A+11|

2.3)

a) Haciendo el grafo de precedencia nos queda que no tiene ciclos y tiene a T3 como sumidero

b) Orden topológico: T1 -> T2 -> T4 -> T3

2.4)

T1 = l1(A); r1(A); w1(A); l1(B); r1(B); w1(B); u1(A); u1(B);\
T2 = l2(A); r2(A); w2(A); l2(B); r2(B);  w2(B); u2(A); u2(B);


2.5)

a) Cumplen ya que no hay locks después de los unlocks

b) l1(A); l2(B); l2(A); l1(B); u1(A); u2(B); u2(A); u1(B);

Ya con las primer 4 operaciones producimos un *deadlock*.