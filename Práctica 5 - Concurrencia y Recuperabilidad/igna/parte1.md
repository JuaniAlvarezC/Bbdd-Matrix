### Serializabilidad / Recuperabilidad de Historias

1.1) El grafo de precedencia es $T_1 \rightarrow T_2$, como es acíclico sabemos que el orden topológico es un orden serial.\
En este caso es igual al grafo ya que tiene una arista.

H1 = r1(A); w1(A); r2(A); w2(A); r1(B); w1(B); r2(B); w2(B);

Para serialziarla y que no haya conflictos `supongo` hay que intercambair r1(B); w1(B); con r2(A); w2(A); que son adyacentes

H1' = r1(A); w1(A); r1(B); w1(B); r2(A); w2(A); r2(B); w2(B);

---
1.2)a)
- $H_1$ es **RC** ya que todas las transacciones hacen commit después de que la transaccion de la que leyeron hace commit.
- $H_2$ es **ACA** ya que lee sólo valores de transacciones que ya hicieron commit.
- $H_3$ es **ACA** (mismo motivo que $H_2$)
- $H_4$ es **RC** (mismo motivo que $H_1$)
- $H_5$ es **ACA** (mismo motivo que $H_2$)

b)
- $H_1$ *lost update* por la primer escritura sobre X en T1 y T4 y sobre Y entre T3 y T4
- $H_2$ *lost update* por la primer escritura sobre X en T1 y T2
- $H_3$ *lost update* por la primer escritura sobre X en T1 y T2
- $H_4$ *dirty read* por la primer escritura y primer lectura sobre X, además un *lost update* en Y
- $H_5$ *lost update* ya que T1 y T3 escriben sobre X sin una lectura previa a la primer escritura

---

1.3) 
- $H_1$ es **ST** ya que todas las transacciones leen o escriben el elemento luego de que la transacción que lo escirbe hace commit
- $H_2$ es **NoRC** ya que T2 lee Y después de que T3 lo escriba y T2 realiza primero commit luego de T3.
- $H_3$ es **ACA** ya que solo lee de transacciones que hicieron commit.

---

1.4

- $H_1 = r_2(D);w_1(B);r_1(C);r_2(B);w_2(C);c_2;w_1(C);c_1$ : T2 hace commit antes que T1 habiendo leído B luego de que T1 la haya escrito **NoRC**
- $H_2 = r_2(D);w_1(B);r_1(C);w_1(C)w_2(C);c_1;r_2(B);c_2$ : Todas leen de transacciones que hicieron commit pero T2 escribe C luego de que T1 escribe C **ACA**
- $H_3 = r_2(D);w_1(B);r_1(C);w_1(C);c_1;w_2(C);r_2(B);c_2$ : Todas lee y escriben de transacciones que hicieron commit, **ST**