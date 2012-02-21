// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
window.onload = function(){
  $$('.month_link').each(function(each_link){
    each_link.is_red = false;
    each_link.onclick = function() {
      if(each_link.is_red) {Effect.SlideUp("_"+each_link.id, {duration: 0.5});
        each_link.style.color = '';
        each_link.is_red = false;}
      else {
        Effect.SlideDown("_"+each_link.id,{ duration: 0.5 });
        each_link.style.color = 'red';
        each_link.is_red = true;
      }
    }
  });
}


