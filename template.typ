// Mise en page commune. Chaque exercice est un point d'entrée qui applique
// `document`; le contenu n'a besoin que des blocs (remarque, algo).
//
// PDF : mise en page A4. HTML : pas de page, le style vient de site/style.css.

#let _blue = rgb("#003087") // bleu ÉTS
#let _red = rgb("#DA291C") // rouge ÉTS
#let _grey = luma(140)

// Bloc de remarque, rendu en <div class="callout"> dans le HTML.
#let remarque(body) = context {
  if target() == "html" {
    html.elem("div", attrs: (class: "callout"))[*Remarque.* #body]
  } else {
    block(fill: luma(245), inset: 10pt, radius: 3pt, width: 100%)[*Remarque.* #body]
  }
}

// Algorithme en pseudo-code : un bloc de code sans coloration.
#let algo(body) = raw(block: true, lang: none, body)

#let document(
  title: "",
  subtitle: none,
  course: "LOG200",
  student: "Vianney Veremme",
  term: "Automne 2026",
  date: datetime.today().display("[year]-[month]-[day]"),
  slug: "document", // nom du fichier sur le site (slug.html, slug.pdf)
  body,
) = {
  set std.document(title: title, author: student)
  set text(font: "New Computer Modern", size: 11pt, lang: "fr")
  set par(justify: true, leading: 0.65em, spacing: 1.2em)
  set heading(numbering: "1.1")
  show link: set text(fill: blue)

  show heading.where(level: 1): set text(size: 14pt, fill: _blue)
  show heading.where(level: 2): set text(size: 12pt, fill: _blue)

  show raw.where(block: false): box.with(fill: luma(235), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 2pt)
  show raw.where(block: true): block.with(fill: luma(240), inset: (x: 1em, y: 0.8em), radius: 4pt, width: 100%)

  let meta = [#student · #course · #term · #date]

  context if target() == "html" {
    html.elem("link", attrs: (rel: "stylesheet", href: "style.css"))
    html.elem("nav", html.elem("a", attrs: (href: "index.html"))[← Exercices])
    html.elem("header", attrs: (class: "title"))[
      #heading(level: 1, numbering: none, outlined: false, title)
      #if subtitle != none { html.elem("p", attrs: (class: "subtitle"), subtitle) }
      #html.elem("p", attrs: (class: "subtitle"), meta)
      #html.elem("p", attrs: (class: "pdf"), html.elem("a", attrs: (href: slug + ".pdf"))[Version PDF])
    ]
    body
  } else {
    set page(
      paper: "a4",
      margin: (top: 2.5cm, bottom: 2.5cm, x: 2.4cm),
      numbering: "1",
      header: context if counter(page).get().first() > 1 {
        set text(size: 9pt, fill: _grey)
        course + " \u{2014} " + title
        v(-0.5em)
        line(length: 100%, stroke: 0.4pt + luma(210))
      },
    )

    align(center)[
      #text(size: 20pt, weight: "bold", fill: _blue, title)
      #if subtitle != none { linebreak(); text(size: 13pt, fill: _blue, subtitle) }
      #v(0.3em)
      #line(length: 40%, stroke: 1.2pt + _red)
      #v(0.3em)
      #text(fill: _grey, meta)
    ]
    v(1em)
    body
  }
}
