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

  var best = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter_withshadow&chld=%E2%80%A2|33CC33|000000';
  var better = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter_withshadow&chld=%E2%80%A2|FFFF00|000000';
  var good = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter_withshadow&chld=%E2%80%A2|FF6633|000000';

  for(var i=0; i<restaurants.length; i++){
    markerLatLng = new google.maps.LatLng(restaurants[i].restaurant.x, restaurants[i].restaurant.y);
    markerPositions.push(new google.maps.LatLng(restaurants[i].restaurant.x, restaurants[i].restaurant.y));

    if (restaurants[i].restaurant.rating >= 4.5) {
      icon = best;
    } else if (restaurants[i].restaurant.rating >= 4.0) {
      icon = better;
    } else {
      icon = good;
    }
    markers.push(new google.maps.Marker({
      icon: icon,
      position: markerLatLng,
      map: map,
      title: restaurants[i].restaurant.name
    }));

    var address = JSON.parse(restaurants[i].restaurant.address).join(', ');
    var hours = JSON.parse(restaurants[i].restaurant.hours).join('<br/>');
    markerWindows.push(new google.maps.InfoWindow({
      content: 
        '<div style="text-align: left">' +
        '<a href="/restaurants/' + restaurants[i].restaurant.id + '">' + restaurants[i].restaurant.name + '</a><br/>' +
        'Rating: ' + '<b>' + restaurants[i].restaurant.rating + '</b><br/>' +
        address + '<br/>' +
        hours + '<br/>' +
        '</div>'
    }));
    google.maps.event.addListener(markers[i], 'click', infoCallback(markerWindows[i], markers[i]));
  }
}
