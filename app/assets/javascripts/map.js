$(document).on('page:change', function() {

  function init_map() {
    var myOptions = {
      zoom:15,
      center:new google.maps.LatLng(32.832334,-117.14482900000002),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("gmap_canvas"), myOptions);
    marker = new google.maps.Marker({map: map,position: new google.maps.LatLng(32.832334, -117.14482900000002)});
    infowindow = new google.maps.InfoWindow({
      content:"<a href='https://maps.google.com?q=8333+Clairmont+Mesa+Blvd+#215+San+Diego+92111'><b>Ace CPR San Diego</b></a><br/>8333 Clairemont Mesa Blvd #215<br/>San Diego, 92111" });
    google.maps.event.addListener(marker, "click", function() {
      infowindow.open(map,marker);
    });
    infowindow.open(map,marker);
  }
  google.maps.event.addDomListener(window, 'load', init_map);

});