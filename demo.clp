#[span
  menu
  #[h1 "hello world"]
  (req-info S)
  #[ul (map
         (fn [i]
            #[li #[a ^{:href (append "/" i)} (append "item " i)]])
         alist)]
  #[h1 "ajax demo"]
  (quoi#ajax-button "submit" S
    (fn [S]
      #[p "A new data from server!!!"])
"function(data){
  $('#ajax_content').html(data);
}")
  #[span ^{:id "ajax_content"}]
  #[h1 "comet demo"]]
