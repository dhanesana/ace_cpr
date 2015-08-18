$(document).ready(function() {

  $('.types').click(function() {
    window.location = $(this).find('a').attr('href');
  }).hover(function() {
    $(this).toggleClass('hover');
  });

});
