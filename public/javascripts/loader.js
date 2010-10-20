(function() {
  var latlng = new google.maps.LatLng(x, y) //38.95, -77.46);
  var myOptions = {
    zoom: zoom,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
  var markers = [];
  var markerCoords = [];
  var markerLatLng = [];
  var contentString = '';
  var markerWindows = [];

  for(var i = 0; i<restaurants.length; i++){
    markerCoords = [restaurants[i].restaurant.x, restaurants[i].restaurant.y];
    markerLatLng = new google.maps.LatLng(parseFloat(markerCoords[0]), -parseFloat(markerCoords[1]));
    markers.push(new google.maps.Marker({
      position: markerLatLng,
      map: map,
      title: restaurants[i].restaurant.title
    }));

    contentString = restaurants[i].restaurant.title;
    markerWindows.push(new google.maps.InfoWindow({
      content: contentString
    }));

    google.maps.event.addListener(markers[i], 'click', function(){
      markerWindows[i].open(map,markers[i]);
    });
  }
})();

$("#restaurant_table").tablesorter();
