#[span
  menu
  #[h2 "What is Quoi?"]
  #[p "Quoi is a simple web framework by CljPerl."]
  #[h2 "What are special?"]
  (quoi#sortable-table
    ["Key featrues"]
    ["Progromming in Lisp but seamless connection with Perl."]
    ["Native xml form of CljPerl makes web template easy."]
    ["Ajax/Comet supports."])
  #[h2 "Quoi app file"]
  #[pre #[code
"; load quoi
(require quoi)

; load quoi menu utils
(require quoi/menu)

; create a menu
(def menu (quoi#menu
  [\"Home\" \"home\" (quoi#file \"index.clp\")]
  [\"About\" \"about\" (quoi#file \"about.clp\")]))

; set the index page.
(quoi#page \"/$\"
  (quoi#file \"index.clp\"))

(quoi#start {:port 9090})
"]]
  #[h2 "Quoi html template file"]
  #[pre #[code
"
#[span
  #[h1 \"hello world\"]
  menu]
"]]
  #[h2 "Run quoi app"]
  #[pre #[code "cljp app.clp"]]
  ]
