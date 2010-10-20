function initialize() {
  var latlng = new google.maps.LatLng(x, y);   //38.95, -77.46);
  var myOptions = {
    zoom: zoom,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
  var markers = [];
  var markerWindows = [];
  var markerPositions = [];

  function infoCallback(markerWindow, marker, markerPosition) {
    return function() {
      markerWindow.open(map, marker);
      map.setCenter(marker.position);
    };
  }

  for(var i=0; i<restaurants.length; i++){
    markerLatLng = new google.maps.LatLng(restaurants[i].restaurant.x, -restaurants[i].restaurant.y);
    markerPositions.push(new google.maps.LatLng(restaurants[i].restaurant.x, -restaurants[i].restaurant.y));
    markers.push(new google.maps.Marker({
      position: markerLatLng,
      map: map,
      title: restaurants[i].restaurant.name
    }));
    markerWindows.push(new google.maps.InfoWindow({
      content: restaurants[i].restaurant.name
    }));
    google.maps.event.addListener(markers[i], 'click', infoCallback(markerWindows[i], markers[i]));
  }
}
