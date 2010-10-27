function infoCallback(markerWindow, marker, markerPosition) {
  return function() {
    markerWindow.open(map, marker);
    map.setCenter(marker.position);
  };
}

google.maps.Map.prototype.markers = new Array();

google.maps.Map.prototype.clearMarkers = function() {
  for (var i=0; i < this.markers.length; i++) {
    this.markers[i].setMap(null);
  }
  this.markers = new Array();
}

google.maps.Map.prototype.addMarkers = function(restaurants) {
  this.clearMarkers();
  var markerWindows = [];

  for(var i=0; i<restaurants.length; i++){
    markerLatLng = new google.maps.LatLng(restaurants[i].x, restaurants[i].y);

    if (restaurants[i].rating >= 4.5) {
      icon = best;
    } else if (restaurants[i].rating >= 4.0) {
      icon = better;
    } else {
      icon = good;
    }
    map.markers.push(new google.maps.Marker({
      icon: icon,
      position: markerLatLng,
      map: map,
      title: restaurants[i].name
    }));

    var address = JSON.parse(restaurants[i].address).join(', ');
    var hours = JSON.parse(restaurants[i].hours).join('<br/>');
    markerWindows.push(new google.maps.InfoWindow({
      content: 
        '<div style="text-align: left">' +
        // '<a href="/restaurants/' + restaurants[i].id + '">' + restaurants[i].name + '</a><br/>' +
        '<b>' + restaurants[i].name + '</b><br/>' +
        'Rating: ' + '<b>' + restaurants[i].rating + '</b><br/>' +
        address + '<br/>' +
        hours + '<br/>' +
        '</div>'
    }));
    google.maps.event.addListener(map.markers[i], 'click', infoCallback(markerWindows[i], map.markers[i]));
  }
}
