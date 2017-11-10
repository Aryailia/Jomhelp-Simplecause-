function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.42, lng: 150.9},
    zoom: 17
  });
  var card = document.getElementById('pac-card');
  var input = document.getElementById('pac-input');
  var types = document.getElementById('type-selector');
  var strictBounds = document.getElementById('strict-bounds-selector');

  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(card);

  var autocomplete = new google.maps.places.Autocomplete(input);

  // Bind the map's bounds (viewport) property to the autocomplete object,
  // so that the autocomplete requests use the current map bounds for the
  // bounds option in the request.
  //autocomplete.bindTo('bounds', map);

  var infowindow = new google.maps.InfoWindow();
  var infowindowContent = document.getElementById('infowindow-content');
  infowindow.setContent(infowindowContent);
  var marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29)
  });

  autocomplete.addListener('place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      // User entered the name of a Place that was not suggested and
      // pressed the Enter key, or the Place Details request failed.
      window.alert("No details available for input: '" + place.name + "'");
      return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);  // Why 17? Because it looks good.
    }
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }

    infowindowContent.children['place-icon'].src = place.icon;
    infowindowContent.children['place-name'].textContent = place.name;
    infowindowContent.children['place-address'].textContent = address;
    infowindow.open(map, marker);

    processOutput(place);
  });
}

function processOutput(place) {
  var $fullAddress = $(place.adr_address);
  // var address = [place.name]
  //   .concat(
  //     $fullAddress
  //       .filter('.street-address .locality')
  //       .toArray()
  //       .map(function (x) { return x.innerHTML; })
  //   ).join(', ');
  var address = place.name + ', ' + place.formatted_address;

  // console.log(place);
  
  document.getElementById('address').value = address;
  document.getElementById('city').value = $fullAddress.filter('.locality').html();
  document.getElementById('postcode').value = $fullAddress.filter('.postal-code').html();
  document.getElementById('longitude').value = place.geometry.location.lat();
  document.getElementById('latitude').value = place.geometry.location.lng();
}

$(document).ready(function () {
  // Stop the Enter from submitting form
  document.getElementById('google_map_entry').addEventListener('keypress', function (e) {
    if (e.keyCode === 13) {
      e.preventDefault();
    }
  });
});