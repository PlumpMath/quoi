#[span
  menu
  #[h2 "Hello world"]
  (req-info S)
  #[ul (map
         (fn [i]
            #[li #[a ^{:href (append "/" i)} (append "item " i)]])
         alist)]
  #[h2 "Ajax demo"]
  #[pre #[code
"
#[span ^{:id \"ajax_content\"}]
(quoi#ajax-button \"submit\"
  (fn [S]
    #[p \"A new data from server!!!\"])
  {:ajax-done
   \"function(data){
    $('#ajax_content').html(data);
   }\"
  })"
]]
  (quoi#ajax-button "submit"
    (fn [S]
      #[p "A new data from server!!!"])
{:ajax-done
"function(data){
  $('#ajax_content').html(data);
}"})
  #[span ^{:id "ajax_content"}]
  #[h2 "Comet demo"]
  #[pre #[code
"
; app.clp
(def sockets ())

(quoi#comet-server nil 9091
  (fn [socket]
    (if (> (length sockets) 10000)
      (begin
        (quoi#socket-destroy socket))
      (begin
        (set! sockets (cons socket sockets))
        (quoi#socket-on-read socket
          (fn [data]
            (map 
              (fn [s]
                (quoi#socket-send s data))
               sockets)))))))

------------------------------

// html javascript
  var socket = new WebSocket('ws://localhost');
  socket.onopen = function(){
  };
  socket.onmessage = function(evt){
    $('#comet_msg').html(evt.data);
  };
  $('#comet_submit').on('click', function(){
    socket.send($('#comet_input').val());
  });

"]]
  #[input ^{:type "text" :id "comet_input"}]
  #[input ^{:type "submit" :id "comet_submit" :value "submit"}]
  #[br] #[span "broadcast: "]
  #[span ^{:id "comet_msg"}]
  #[script
"
  var socket = new WebSocket('ws://localhost');
  socket.onopen = function(){
  };
  socket.onmessage = function(evt){
    $('#comet_msg').html('<p>' + evt.data + '</p>' + $('#comet_msg').html());
  };
  $('#comet_submit').on('click', function(){
    socket.send($('#comet_input').val());
    $('#comet_input').val(\"\");
  });
"
  ]
  ]
