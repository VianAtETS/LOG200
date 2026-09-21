#!/bin/sh
# Construit le site : un PDF et un HTML par exercice, dans _site/.
# Le même script tourne dans la CI et en local (depuis la racine) :   sh site/build.sh
#
# Ajouter un exercice = une ligne ici + une entrée dans site/index.html.
# Le slug doit correspondre à celui passé à `document.with(slug: ...)`, qui
# l'utilise pour le lien « Version PDF ».
set -eu

out=_site
rm -rf "$out"
mkdir -p "$out"
cp site/index.html site/style.css "$out/"

while read -r slug src; do
  [ -z "$slug" ] && continue
  echo "== $slug ($src)"
  typst compile --root . "$src" "$out/$slug.pdf"
  typst compile --root . --features html --format html "$src" "$out/$slug.html"
done <<LIST
semaine_03-exercice_01   semaine_03/exercice_01.typ
LIST
