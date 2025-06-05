### Sistemas de Bloqueo con varios modos

3.1) 

H =\
wl1(A); A = A + 1; rl2(A); wl1(B); B = A + B; u1(A); u1(B);\
wl2(C); C = A + 1; wl2(D); D = 1; u1(A); u2(D); u2(C)

a) No es serial ya que rl2(A) se encuentra entre las primeras transacciones de T1 y es legal.

b) No es 2PL ya que hay locks luego de unlocks.

3.2) 

El grafo de precedencias es acíclico con sumidero en T4

T1 -A-> T4\
T2 -B-> T1\
T2 -A-> T3\
T2 -B-> T4\
T3 -A-> T1\
T3 -A-> T4

Orden topológico: T2 -> T3 -> T1 -> T4

3.3)

|T1|T2|T3|T4|T5|
|-|-|-|-|-|
|rl(A)|||||
||rl(A)||||
|||rl(A)|||
|u(A)|||||
|||||rl(B)|
|||||u(B)|
|wl(B)|||||
||wl(C)||||
|u(B)|||||
|||rl(B)|||
|||u(A)|||
||u(A)||||
||||wl(A)||
||||u(A)||
|rl(D)|||||
|u(D)|||||
||||wl(D)||
||||u(D)||
|||||wl(A)|
|||||u(A)|
||u(C)||||
|||u(B)|||

b)
No es serializable ya que el grafo tiene un ciclo T1 -> T3 -> T5 -> T1

c) Cumple con 2PL?
- T1: No cumple
- T2: Cumple
- T3: Cumple
- T4: No cumple
- T5: No cumple

d)
- T2: Tenemos que poner el commit luego de u(C) con lo cual es **Riguroso**, no puede ser **Estricto**.
- T3: Podemos poner el commit entre u(A) y u(B) para que sea **Estricto** y luego de u(C) para que sea **Riguroso**.

3.4)

a)
H = wl4(A); u4(A); wl3(A); u3(A); rl1(A); rl2(B); u1(A); rl3(B); u2(B);\
rl2(A); u2(A); u3(B); wl1(B);  u1(B); u4(B); wl2(B)

Es legal y serializable

- T4 -> T2 -> T3 -> T1
- T2 -> T4 -> T3 -> T1

b) No es serializable, exsite el ciclo T2 -> T4 -> T3 -> T2

c)

wl3(A); rl4(B); u3(A); wl4(A); u4(A); rl1(A); u4(B); wl3(B); rl2(A); u3(B); wl1(B); u1(A); u1(B); rl2(B); u2(A); u2(B)

ES 2PL

3.5)

a) T3 -> T1 -> T2 o T1 -> T3 -> T2

b) wl3(B); rl3(B); rl1(A); rl3(C); u3(B); rl1(B); u1(B); wl2(B) : u3(C); rl2(C); u3(A); u1(A); wl2(A); u2(B); u2(A); wl2(C); u2(C); rl1(C); rl3(D); u3(D); u1(C); 

En este caso es serial pero T2 escribe antes C por lo tanto el grafo es un ciclo de 3 nodos T1 -> T3 -> T2 -> T1

c) Si, T3 escribe C y T1 lo lee antes de que T3 haga commit

3.6)

a) Es legal y todos son 2PL menos T1

b) Es serializable, historias equivalentes:
- T3 -> T2 -> T4 -> T1
- T3 -> T2 -> T1 -> T4

c) Es RC ya que todas las transacciones hacen commit luego de que las transacciones de las cuales leyeron lo hacen. No es ACA ya que see lee de trasnacciones que todavía no hicieron commit.

d) Ya no es RC ya que T4 hace commit antes que T3 y previamente había leído Y de la escritura de T3

e) 

rl3(X); rl2(X); wl3(Y); u3(X); c3; wl2(X); c2; u3(Y); rl4(Y); u2(X); rl1(Y); rl4(X); u4(X); wl1(X); u1(X); c4; c1; u1(Y); u4(Y); 

Cambiamos el wl1(X) para que sea antes que u1(Y) y adelantamos el u4(X) para que sea legal.

3.7)

3.8)
H = rl1(A); r1(A); rl2(B); r2(B); u1(A); rl1(B); r1(B); wl1(B); w1(B); u2(B); rl2(A); r2(A); u1(B); u2(A);

En este caso el wl1(B) debe esperar al u2(B)

3.9)

a)
H = rl1(A); r1(A); rl2(A); r2(A); wl1(A); wl2(A); w1(A); u1(A); w2(A);  u2(A);

Las escriutas del 5 y 6 pasos nunca se ejecutan.

b)
H = ul1(A); r1(A); rl2(A); r2(A); wl1(A); wl2(A); w1(A); u1(A); w2(A);  u2(A);

rl2(A) va a esperar el u1(A) para ser ejecutado

3.10)

H1 = r1(A); r2(B); r3(C); r1(B); r2(C); r3(D); w1(C); w2(D); w3(E)

a) Locks r/w tal que no haya upgrade

H1 =\
rl1(A); r1(A);\
rl2(B); r2(B);\
rl3(C); r3(C); u3(C);\
rl1(B); r1(B);\
rl2(C); r2(C); u2(C);\
rl3(D); r3(D); u3(D);\
wl1(C); w1(C);\
wl2(D); w2(D);\
wl3(E); w3(E);\
u1(A); u2(B); u1(B;) u1(C); u2(D); u3(E)

b) Locks r/w tal que haya upgrade

H1 =\
rl1(A); r1(A);\
rl2(B); r2(B);\
rl3(C); r3(C); u3(C);\
rl1(B); r1(B);\
rl2(C); wl1(C); r2(C); u2(C);\
rl3(D); r3(D); u3(D);\
wl1(C); w1(C);\
wl2(D); w2(D);\
wl3(E); w3(E);\
u1(A); u2(B); u1(B;) u1(C); u2(D); u3(E)

c) Que haya update locks

H1 =\
rl1(A); r1(A);\
rl2(B); r2(B);\
ul1(C);\
rl3(C); r3(C);\
rl1(B); r1(B);\
rl2(C); r2(C); u2(C);\
rl3(D); r3(D); u3(D);\
wl1(C); w1(C);\
wl2(D); w2(D);\
wl3(E); w3(E);\
u1(A); u2(B); u1(B;) u1(C); u2(D); u3(E)

3.11)

a) trivial(?

b) 

H = rl1(A); rl2(C); rl3(B); rl4(D); wl4(A); wl2(A); wl1(B); wl3(C); ...

c)
- T1 -B-> T3
- T3 -C-> T2
- T2 -A-> T1
- T4 -A-> T1

d)
- Wait-Die: Abortan T4 y T2 y a T1 se lo pone en espera
- Wound-Wait: T4 y T2 quedan en espera y T3 aborta

3.12)

H1 = r1(A); r2(B); w1(C); r3(D); r4(E); w3(B); w2(C); w4(A); w1(D);

a) 
H1 = 
rl1(A); r1(A);\
rl2(B); r2(B);\
wl1(C); w1(C);\
rl3(D); r3(D);\
rl4(E); r4(E);\
wl3(B); w3(B);\
wl2(C); w2(C);\
wl4(A); w4(A);\
wl1(D); w1(D);\
u1(A); u1(C); u1(D);\
u2(B); u2(C);\
u3(D); u3(B);\
u4(E); u4(A);\


b - c)

Tenemos deadlock entre T1, T2 y T3

Acciones bloqueadas: wl2(C), wl1(D), wl3(B)

aristas:
- T1 -D-> T3
- T2 -C-> T1
- T3 -B-> T2
- T4 -A-> T1

d) 
- Wait-Die: Abortan T3 y T2; se pone en espera a T1
- Wound-Wait: Se pone en espera a T2 y se aborta T3