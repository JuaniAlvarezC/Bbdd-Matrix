### Métodos con timestamping y Multiversión

4.1)

H1 = st1; st2; r1(A); r2(B); w2(A); w1(B)

Si TS(T1) = 100 y TS(T2) = 200

*Timestamping*\
Tiene que hacer **rollback** de T1 ya que TS(T1) < RT(B) es físicamente irrealizable

||RT|WT|C|
|-|-|-|-|
|A|100|200|
|B|200|!|

*MVTO*\
T1 es rechazada y abortada cuando quiere hacer w1(B) ya que antes se procesó r2(B) y TS(T1) < TS(T2)

T1|T2
-|-
r1(A0)|
||r2(B0)
||w2(A1)
!|

---
H2 = st1; r1(A); st2; r2(B); r2(A); w1(B)

Si TS(T1) = 100 y TS(T2) = 200

*Timestamping*\
Tiene que hacer **rollback** de T1 ya que TS(T1) < RT(B) es físicamente irrealizable

||RT|WT|C|
|-|-|-|-|
|A|200||
|B|200|!|

*MVTO*\
T1 es rechazada y abortada cuando quiere hacer w1(B) ya que antes se procesó r2(B) y TS(T1) < TS(T2)

T1|T2
-|-
r1(A0)|
||r2(B0)
||r2(A0)
!|

---
H3 = st1;st2;st3; r1(A); r2(B); w1(C); r3(B); r3(C); w2(B); w3(B);

Si TS(T1) = 100, TS(T2) = 200 y TS(T3) = 300

*Timestamping*\
Cuando se realiza r3(C) debe esperar a que T1 haga commit, asumimos que hace commit ni bien termina la última operación.\
Tiene que hacer **rollback** de T2 ya que TS(T2) < RT(B) es físicamente irrealizable.

||RT|WT|C|
|-|-|-|-|
|A|100||
|B|300|300|
|C|300|100|

*MVTO*\
T2 es rechazada y abortada cuando quiere hacer w2(B) ya que antes se procesó r3(B) y TS(T2) < TS(T3)

T1|T2|T3
-|-|-
r1(A0)|
||r2(B0)
w1(C1)||
|||r3(B0)
|||r3(C1)
||w2(B)!
|||w3(B1)

4.2)

H1 = st1; st2; r2(X); st3; st4; r1(Y); r4(Z); w3(X); w3(Y); w4(Z); w2(X); w1(Y); r3(Z)

T1 escribe Y = 1\
T2 escribe X = 2\
T3 escribe X = 3; Y = 30\
T4 escribe Z = 4

TS(Ti) = i * 100 

a) *Timestamping*

||=|RT|WT
-|-|-|-
X|3|200|300
Y|30|100|300
Z|4|400|400

- En w2(X) y w1(Y) tenemos la regla de Thomas
- Se hace rollback de T3 en r3(Z) ya que TS(T3) < WT(Z)

Termina siendo:
||=|RT|WT
-|-|-|-
X|2|200|200
Y|1|100|100
Z|4|400|400

b) *MVTO* 

Supongo que los commits se hacen inmediatamente después de la última operación

T1|T2|T3|T4
-|-|-|-
||r2(X0)
r1(Y0)
||||r4(Z0)
|||w3(X3)
|||w3(Y3)
||||w4(Z4)
||||c4
||w2(X2)!
||a2
w1(Y1)
|||r3(Z0)
|||c3
c1

- T2 es abortada en w2(X)

X = 3, Y = 1 , Z = 4

c)

Tendríamos una única arista de T4 a T3, con lo cual es acíclico. Por lo tanto, es MCSR.

4.3)

H = st1; st2; st3; r1(A); r1(B); r3(B); r3(X); w1(X); ...

*Write too late*, T1 es abortada en w1(X) ya que T3 ya leyó X y TS(T1) < TS(T3)

4.4)

a)

H1 = st3; st2; st1; r1(A); r2(A); w1(A); r3(A); w3(A); w2(A)\
H2 = st1; st3; st2; r1(A); r3(C); r2(C); w3(A); r2(B); r3(B); w2(B); w2(A)

b) H2 = st1; st3; st2; r1(A); r3(C); r2(C); r2(B); w2(B); w2(A); w3(A); r3(B)

En este caso w3(A) se queda esperando a que T2 haga commit por el w2(A)

4.5)

a) 

H1 = st2; r2(Z); r2(Y); w2(Y); st3; r3(Y); r3(Z); st1; r1(X); w1(X); w3(Y); w3(Z);
r2(X); r1(Y); w1(Y); w1(X)

- TS(T2) = 100
- TS(T3) = 200
- TS(T1) = 300

Estado final:

||RT|WT
|-|-|-
|X|300|300
|Y|300|300
|Z|200|200

Con r2(X) se hace rollback de T2.

H2 = st3; r3(Y); r3(Z); st1; r1(X); w1(X); w3(Y); w3(Z); st2; r2(Z); r1(Y); w1(Y); r2(Y); w2(Y); r2(X); w2(X)

- TS(T3) = 100
- TS(T1) = 200
- TS(T2) = 300

Estado final:

||RT|WT
|-|-|-
|X|300|300
|Y|300|300
|Z|300|100

Esta historia es permitida.

b)

H2 = st3; r3(Y); r3(Z); st1; r1(X); w1(X); w3(Y); st2; r2(Z); r1(Y); `w1(Y);` r2(Y); w2(Y); r2(X); w2(X); `w3(Z)`

Si w3(Z) ocurre al final entonces cuando T1 y T2 quieran hacer w(Y), en partiucales T1 que es un paso final, debe esperar a que T3 commitee para poder ejecutar la escritura.

c)

H2 = st3; r3(Y); r3(Z); st1; r1(X); w1(X); st2; r2(Z); `r1(Y); w3(Y);` w1(Y); r2(Y); w2(Y); r2(X); w2(X); w3(Z)

Cuando T3 hace w(Y) debe abortar por *write too late* ya que previamente T1 hizo r(Y) y TS(T1) > TS(T3)

4.6)

H = st1; r1(A); st3; r3(C); st2; r3(B); `w3(B); r1(B);` ...

*Read too late* de T1 sobre B ya que T3 es más joven escribe B antes de que T1 lo lea.