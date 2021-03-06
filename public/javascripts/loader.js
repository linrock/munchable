function infoCallback(markerWindow, marker, markerPosition) {
  return function() {
    markerWindow.open(map, marker);
    // map.setCenter(marker.position);
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
      icon = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter_withshadow&chld=' + (i+1) + '|33CC33|000000';
    } else if (restaurants[i].rating >= 4.0) {
      icon = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter_withshadow&chld=' + (i+1) + '|FFD700|000000';
    } else {
      icon = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter_withshadow&chld=' + (i+1) + '|FF6633|000000';
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

google.maps.Map.prototype.addCrosshairs = function() {
  var crosshairsSize = 20;
  var container = this.getDiv();

  if (this.crosshairs) {
    this.removeCrosshairs();
  }
  var crosshairs = document.createElement('img');
  crosshairs.src = '/images/crosshairs.gif';
  crosshairs.style.width = crosshairsSize + 'px';
  crosshairs.style.height = crosshairsSize + 'px';
  crosshairs.style.border = 0;
  crosshairs.style.position = 'relative';
  crosshairs.style.top = ((container.clientHeight-crosshairsSize)/2) + 'px';
  crosshairs.style.left = ((container.clientWidth-crosshairsSize)/2) + 'px';
  crosshairs.style.zIndex = 500;

  container.appendChild(crosshairs);
  this.crosshairs = crosshairs;
}
