$(document).ready(function() {

  $('td').click(function() {
    window.location = $(this).find('a').attr('href');
  }).hover(function() {
    $(this).toggleClass('hover');
  });

});
