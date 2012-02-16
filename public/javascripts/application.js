// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var current_table = null;
window.onload = function(){
  $$('.month_link').each(function(each_link){
    each_link.onclick = function() {
      if(current_table){ current_table.style.display = 'none';/* Effect.SlideUp(current_table.id, {duration: 3.0});*/ }
      var x = $('_'+each_link.id);
      x.style.display = 'block';
      current_table = x;
    }});


};
