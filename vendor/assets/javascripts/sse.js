setTimeout((function() {
  var source;
  source = new EventSource('welcome/check');
  source.addEventListener("refresh", function(e) {
    addMessages($.parseJSON(e.data).messages);
  });
}), 1);

function addMessages(messages){
  for(var i=0; i<messages.length; i++){
    document.writeln(messages[i].content);
  }
}