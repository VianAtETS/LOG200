#!/bin/sh
# Construit le site : un PDF et un HTML par exercice, dans _site/.
# Le même script tourne dans la CI et en local (depuis la racine) :   sh site/build.sh
#
# Il n'y a rien à lister : tout fichier semaine_*/exercice_*.typ est découvert
# automatiquement. Son nom sur le site vient de son chemin
# (semaine_03/exercice_01.typ -> semaine_03-exercice_01) et est passé au
# document avec --input slug=... ; son titre et son sous-titre sont lus dans le
# document lui-même (metadata <exercice>, posée par template.typ).
set -eu

out=_site
rm -rf "$out"
mkdir -p "$out"
cp site/style.css "$out/"

meta=$(mktemp)
trap 'rm -f "$meta"' EXIT INT TERM

for src in semaine_*/exercice_*.typ; do
  [ -e "$src" ] || continue # aucun exercice : le motif reste littéral
  slug=$(printf '%s' "${src%.typ}" | tr '/' '-')
  echo "== $slug ($src)"
  typst compile --root . --input slug="$slug" "$src" "$out/$slug.pdf"
  typst compile --root . --input slug="$slug" --features html --format html "$src" "$out/$slug.html"
  json=$(typst eval --root . --input slug="$slug" --in "$src" --format json 'query(<exercice>).first().value')
  printf '%s\t%s\t%s\n' "$src" "$slug" "$json" >>"$meta"
done

# L'index reprend site/index.template.html et y insère une carte par exercice,
# groupée par semaine.
python3 - "$meta" site/index.template.html "$out/index.html" <<'PY'
import json, sys

meta, template, out = sys.argv[1:]

# Le module html de la bibliothèque standard manque dans le conteneur.
def escape(s):
    return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")

weeks = []  # [(dossier, [carte, ...])], dans l'ordre de découverte
for line in open(meta, encoding="utf-8"):
    src, slug, raw = line.rstrip("\n").split("\t")
    doc = json.loads(raw)
    week = src.split("/")[0]
    if not weeks or weeks[-1][0] != week:
        weeks.append((week, []))
    weeks[-1][1].append((slug, doc["title"], doc.get("subtitle") or ""))

sections = []
for week, exercices in weeks:
    # semaine_03 -> Semaine 3
    name, _, number = week.partition("_")
    title = name.capitalize() + " " + number.lstrip("0") if number.isdigit() else week
    cards = "\n".join(
        f"""    <li><a href="{slug}.html"><strong>{escape(t)}</strong></a>
      <span>{escape(s)}</span>
      <a class="pdf" href="{slug}.pdf">PDF</a>
    </li>"""
        for slug, t, s in exercices
    )
    sections.append(f"  <h2>{escape(title)}</h2>\n  <ul class=\"cards\">\n{cards}\n  </ul>")

page = open(template, encoding="utf-8").read()
marker = "  <!-- exercices -->"
if marker not in page:
    sys.exit(f"{template} : le repère {marker.strip()} est introuvable")
open(out, "w", encoding="utf-8").write(page.replace(marker, "\n\n".join(sections)))
print(f"== index.html ({sum(len(e) for _, e in weeks)} exercices)")
PY
