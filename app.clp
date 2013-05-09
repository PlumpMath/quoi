(require quoi)
(require quoi/menu)
(require quoi/table)
(require quoi/default_template)
(require quoi/ajax)
(require quoi/comet)

(def alist (list "a" "b" "c"))

(def title "Quoi")

(defn req-info [S]
  #[span
   #[p "Http Request Information:"] 
  (quoi#sortable-table
    ["name" "value"] 
    ["path: " (#::path S)]
    ["method: " (#::method S)]
    ["params: " (clj->string (#::params S))]
    ["headers: " (clj->string (#::headers S))]
    ["content: " (clj->string (#::content S))]
    ["client host: " (#::client-host S)]
    ["client port: " (#::client-port S)])])

(def menu
  #[span
  #[style
"
.sf-menu li {
  width:9em;
  font-size: 15px;
  font-weight:bold;
}
"]
  (quoi#superfish-menu
  ["Home" "home" (quoi#default-template title (quoi#file "index.clp"))]
  ["Doc" "doc" (quoi#default-template title (quoi#file "doc.clp"))]
  ["Demo" "demo" (quoi#default-template title (quoi#file "demo.clp"))]
  ["About" "about" (quoi#default-template title (quoi#file "about.clp"))])])

(map (fn [i]
  (quoi#page (append "/" (append i "$"))
    (quoi#default-template title
    (fn [S]
      #[span
        menu
        #[h1 i]
        (req-info S)
        ]))))
  alist)

(quoi#page "/$"
  (quoi#default-template title (quoi#file "index.clp")))

(def sockets {})

(quoi#comet-server nil "http" 
  (fn [socket]
     (#:(object-id socket) sockets socket)
     (quoi#socket-on-read socket
       (fn [data]
         (map 
           (fn [s]
             (let [socket (#:s sockets)] 
               (if (eq (perlobj-type socket) "AnyEvent::Handle::destroyed")
                 (#:s sockets nil)
                 (quoi#socket-send socket data))))
            (keys sockets))))))

(quoi#start {:port 9090})
