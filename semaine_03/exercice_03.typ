#import "../template.typ": document, remarque

#show: document.with(
  title: "Exercice 3",
  subtitle: "Fusionner deux tableaux triés en complexité O(N+M)",
)

= Énoncé

Considérer 2 tableaux triés `T1[1..N]` et `T2[1..M]`. Écrire un algorithme qui crée un
troisième tableau `T3[1..N+M]` qui est aussi trié. La complexité de votre algorithme
doit être en $O(N plus M)$.

= Solution (LeetCode)

Problème #link("https://leetcode.com/problems/merge-sorted-array")[#88. Merge Sorted Array] résolu le #datetime(day: 9, month: 8, year: 2026).display()

```java
class Solution {
    public void merge(int[] nums1, int m, int[] nums2, int n) {
        int pindex = m + n - 1;
        int index1 = m - 1;
        int index2 = n - 1;

        while (index2 >= 0) {
            if (index1 >= 0 && nums1[index1] > nums2[index2])
                nums1[pindex--] = nums1[index1--];
            else
                nums1[pindex--] = nums2[index2--];
        }
    }
}
```

#remarque[`nums1` jour le rôle de `T3`, initialement rempli avec `T1` et de la place libre pour `T2`.]
