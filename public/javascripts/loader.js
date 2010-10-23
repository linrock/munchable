function initialize() {
  var latlng = new google.maps.LatLng(x, y);   //38.95, -77.46);
  var map = new google.maps.Map(document.getElementById("map_canvas"), {
    zoom: zoom,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
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
    markerLatLng = new google.maps.LatLng(restaurants[i].restaurant.x, restaurants[i].restaurant.y);
    markerPositions.push(new google.maps.LatLng(restaurants[i].restaurant.x, restaurants[i].restaurant.y));
    markers.push(new google.maps.Marker({
      position: markerLatLng,
      map: map,
      title: restaurants[i].restaurant.name
    }));
    markerWindows.push(new google.maps.InfoWindow({
      content: 
        '<p><a href="/restaurants/' + restaurants[i].restaurant.id + '">' + restaurants[i].restaurant.name + '</a>' +
        '<p>' + '<p>' + restaurants[i].restaurant.address + '</p>' +
        '<p>' + restaurants[i].restaurant.hours + '</p>'
    }));
    google.maps.event.addListener(markers[i], 'click', infoCallback(markerWindows[i], markers[i]));
  }
}
