      
  $.noConflict();
   jQuery(document).ready(function($) {
      //if height of window is less than that of the document, then
      //set the height of the table so that the footer is pushed to
      //bottom.
      if (jQuery(window).height() > jQuery(document).height()) {
          jQuery('#menucontainer').height(jQuery(window).height() - 45);
      }
      else {
          jQuery('#menucontainer').height(jQuery(document).height() + 15);
      }
 
  });
