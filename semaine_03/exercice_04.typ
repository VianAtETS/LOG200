#import "../template.typ": document, remarque

#show: document.with(
  title: "Exercice 4",
  subtitle: "Trouver un triplet a+b+c=X dans trois tableaux en O(N²) temps et O(1) espace",
)

= Énoncé

Considérer trois tableaux `A[1..N]`, `B[1..N]` et `C[1..N]` et une valeur `X`. Vous devez concevoir un algorithme avec une complexité en $O(N^2)$ et avec la mémoire de travail en $O(1)$ qui va trouver trois valeurs $a in A, b in B, c in C$ de tel sorte que $a plus b plus c eq X$.

= Solution
