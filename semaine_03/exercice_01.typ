#import "../template.typ": document, remarque

#show: document.with(
  title: "Exercice 1",
  subtitle: "Pile implémentée avec une liste simplement chaînée",
)

= Énoncé

Nous avons vu en classe les différents algorithmes pour une pile. Ces algorithmes utilisaient un tableau pour implémenter une pile. Écrire les algorithmes `EstVide(pile)`, `Push(pile,x)` et `Pop(pile)` dans le contexte d'une liste simplement chaînée.

#line(length: 100%)

- `EstVide`

  ```
  EstVide(pile)
    retourner pile.tete = null
  ```

- `Push`

  ```
  Push(pile, x)
    n ← nouveau Noeud
    n.valeur ← x
    n.suivant ← pile.tete
    pile.tete ← n
  ```

#remarque[L'ordre des deux dernières instructions est important. Si `pile.tete` était modifiée en premier, la référence vers l'ancienne liste serait perdue.]

- `Pop`

  ```
  Pop(pile)
    si EstVide(pile)
        erreur \"pile vide\"
    x ← pile.tete.valeur
    pile.tete ← pile.tete.suivant
    retourner x
  ```

= Exemples

Après `Push(pile, 1)`, `Push(pile, 2)` et `Push(pile, 3)` :

```
tete → [3] → [2] → [1] → null
```

Un `Pop(pile)` retourne alors 3 (le dernier élément ajouté) et la pile devient :

```
tete → [2] → [1] → null
```
