setTimeout((function() {
  var source;
  var x = 0;
  source = new EventSource('welcome/check');
  source.addEventListener("refresh", function(e) {
  	x++;
    addMessages($.parseJSON(e.data).invits,x);
  });
}), 1);

function addMessages(invits,x){
  for(var i=0; i<invits.length; i++){
    // document.writeln(messages[i].content);
    // console.log(x)
     $('.notify').html(x);
  }
}