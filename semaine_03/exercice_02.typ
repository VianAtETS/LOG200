#import "../template.typ": document, remarque

#show: document.with(
  title: "Exercice 2",
  subtitle: "Inversion d'un ensemble en O(N) temps et O(1) espace",
)

= Énoncé

Écrire un algorithme qui inverse les éléments d'un ensemble contenant `N` valeurs. Par exemple, si nous avons l'ensemble `{2,4,3,1,5,10,9}`, l'algorithme doit retourner `{9,10,5,1,3,4,2}`. L'algorithme doit être en $O(N)$ pour la complexité et en $O(1)$ pour l'espace de travail. Écrire votre algorithme en considérant que :
+ L'ensemble est représenté par un tableau
+ L'ensemble est représenté par une liste simplement chaînée

#line(length: 100%)

== Tableau

```
InverserTableau(ensemble, n)
  pour i de 1 à n / 2          // division entière
    ensemble[i] ↔ ensemble[n + 1 - i]
```

== Liste simplement chaînée

```
InverserChaine(liste)
  precedent ← null
  courant ← liste.tete
  tant que courant ≠ null
    suivant ← courant.suivant      // 1. sauvegarder la suite
    courant.suivant ← precedent    // 2. retourner la flèche
    precedent ← courant            // 3. avancer
    courant ← suivant
  liste.tete ← precedent           // precedent est le dernier nœud vu
```
