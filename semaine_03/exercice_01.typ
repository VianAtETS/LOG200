// Point d'entrée : typst compile --root . semaine_03/exercice_01.typ  (depuis la racine)
#import "../template.typ": algo, document, remarque

#show: document.with(
  title: "Exercice 1",
  subtitle: [Pile implémentée avec une liste simplement chaînée],
  slug: "semaine_03-exercice_01",
)

= Énoncé

Les algorithmes vus en classe pour une pile utilisaient un tableau. Écrire les algorithmes `EstVide(pile)`, `Push(pile, x)` et `Pop(pile)` dans le contexte d'une liste simplement chaînée.

= Structures de données

Un *nœud* contient une valeur et une référence vers le nœud suivant. La *pile* ne garde qu'une référence vers son premier nœud, la *tête*, qui est le sommet de la pile. Une pile vide a une tête `null`.

#algo("Noeud
    valeur    // l'élément stocké
    suivant   // référence vers le nœud suivant, ou null

Pile
    tete      // référence vers le sommet, ou null si la pile est vide")

= Algorithmes

== EstVide

#algo("EstVide(pile)
    retourner pile.tete = null")

== Push

#algo("Push(pile, x)
    n ← nouveau Noeud
    n.valeur ← x
    n.suivant ← pile.tete
    pile.tete ← n")

#remarque[L'ordre des deux dernières instructions est important. Si `pile.tete` était modifiée en premier, la référence vers l'ancienne liste serait perdue.]

== Pop

#algo("Pop(pile)
    si EstVide(pile)
        erreur \"pile vide\"
    x ← pile.tete.valeur
    pile.tete ← pile.tete.suivant
    retourner x")

= Exemple

Après `Push(pile, 1)`, `Push(pile, 2)` et `Push(pile, 3)` :

#algo("tete → [3] → [2] → [1] → null")

Un `Pop(pile)` retourne alors 3 (le dernier élément ajouté) et la pile devient :

#algo("tete → [2] → [1] → null")

= Complexité

`EstVide`, `Push` et `Pop` s'exécutent tous en $O(1)$ : ils ne touchent qu'à la tête de la liste, sans parcours. Contrairement à l'implémentation avec un tableau, il n'y a pas de condition « pile pleine » à vérifier : la pile ne peut manquer de place que si la mémoire est épuisée.
