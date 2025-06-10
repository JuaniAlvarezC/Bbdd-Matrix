### Recuperabilidad

5.1)

H= r1(Z); w1(U ); c1; w2(X); w2(Y ); r3(U ); w3(X); w2(Z); c2; r3(Y ); r4(Z); w3(Y ); c3; r4(U ); w4(U ); c4

a)

|H|
|-|
< START T1 >
< T1, U, 0 >
< COMMIT T1 >
< CKPT >
< START T2 >
< T2, X, 0 >
< T2, Y, 0 >
< START T3 >
< T3, X, 1 >
< T2, Z, 0 >
< COMMIT T2 >
< T3, Y, 1 >
< COMMIT T3 >
< CKPT >
< START T4 >
< T4, U, 1 >
< COMMIT T4 >

b) Se baja a disco T1 con el start CKPT

|H|
|-|
< START T1 >
< T1, U, 0 >
< COMMIT T1 >
< START T2 >
< T2, X, 0 >
< T2, Y, 0 >
< START T3 >
< START CKPT (T2, T3) > 
< T3, X, 1 >
< T2, Z, 0 >
< COMMIT T2 >
< T3, Y, 1 >
< COMMIT T3 >
< END CKPT >
< START T4 >
< T4, U, 1 >
< COMMIT T4 >

c) No entiendo que hacer

5.2)

|H|
|-|
< START T1 >
< T1 A 10 >
< START T2 >
< T2 B 20 >
< START T12 >
< T1 C 30 >
< T2 D 40 >
< COMMIT T2 >
< T12 R 12 >
< T1 E 50 >
< ABORT T12 >
< COMMIT T1 >

a)
- Asigna 10 a A
- Agrega 1 abort para T1

b) 
- Asigna 30 a C
- Asigna 10 a A
- Agrega 2 aborts, a T1 y a T12 y lo baja a disco

c) 
- Asigna 50 a E
- Asigna 12 a R
- Asigna 30 a C
- Asigna 10 a A
- Agrega 2 aborts, a T1 y a T12 y lo baja a disco
 
d) No hay transacciones incompletas

5.3)\
a) 
i)
- Asigna 16 A B
- Asigna 8 a A
- Agrga 4 aborts luego de < START T4 >, uno para cada transacción

ii)
- Asigna 56 a C
- Asigna 16 A B
- Asigna 8 a A
- Agrega 1 abort para T1

b) i) Recuperar todo lo de T4 y T3. Además agregar un abort de T2 y T1.

ii) Recupera todo sin ningún abort

5.4)

a) Asigna 100 a A y 200 a B. Luego agrega 3 aborts, uno para cada transacción

b) Deshace todo lo que hicieron T1 y T2, es decir, asigna 100 a A, 200 a B, 300 a C y 40 a E. Luego, rehace T3, asigna 410 a D y 510 a E. Agrega los aborts de T1 y T2 luego del commit de T3.

c) Desahce las incompletas T1 y rehace las completas T2 y T3. Agrega abort de T1.

d) No hay transacciones inompletas, el log queda igual y rehace todos los updates.

5.5)

CKPT de T1\
1a) Luego del < COMMIT T1 >\
1b) Desde el END CKPT hacia atrás (hasta START T1)

CKPT de T2\
2a) Luego del < COMMIT T2 >\
2b) Desde el END CKPT hacia atrás (hasta START T2)

CKPT de T2 y T3\
3a-b) Igual al 2

CKPT de T2, T3 y T4\
4a) Luego del < COMMIT T4 >\
4b) Desde el END CKPT hacia atrás (hasta START T2)

CKPT de T2 y T4\
5a) Luego del < COMMIT T4 >\
5b) Desde el END CKPT hacia atrás (hasta START T2)

5.6)