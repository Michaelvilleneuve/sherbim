var map;
var markers = [];
var infowindow = [];
var marker = [];
var infoWindows = [];

function clearOverlays() {
  for (var i = 0; i < markers.length; i++ ) {
    markers[i].setMap(null);
  }
  markers.length = 0;
}

function showMarkers(id) {

    var geocoder = new google.maps.Geocoder();
	if (typeof id === 'undefined') { id = 0; }
	if(typeof markers !== 'undefined') { clearOverlays(); }
	$.getJSON('/services.json',function(data){
		console.log(data);
		$.each( data, function( key, val ) {
				
			  var contentString = '<div id="content">'+
			      '<div id="siteNotice">'+
			      '</div>'+
				  	  '<div class="map-content">'+
					      '<h2>'+val.title+'</h2>'+
					      '<h3 style=" font-size: 14px; margin: 6px 0px;">'+val.place+'</h3>'+
					      '<hr style="border-color: #999;margin:10px 0px;width:20%;">'+
					      '<div id="bodyContent">'+
					      '<p>'+val.description.substring(0, 220)+'</p>'+
				'<a href="/services/'+val.id+'">'+
						'Voir en détail'+
				'</div>'+
					  '</div>'+
			      '</div>';

                geocoder.geocode( { 'address': val.place}, function(results, status) {
                  var location = results[0].geometry.location;
                  var latitude = location.lat(); 
                  var longitude = location.lng();
                    
                  var infowindow = new google.maps.InfoWindow({
                    content: contentString
                  });
                  infoWindows.push(infowindow);


                  var marker = new google.maps.Marker({
                    position: {lat : latitude, lng : longitude},
                    map: map,
                    title: val.title,
                    animation : google.maps.Animation.DROP,
                  });
                    marker.addListener('click', function() {
                        for (var i=0;i<infoWindows.length;i++) {
                            infoWindows[i].close();
                        }
                        infowindow.open(map, marker);
                  
                  });
                  markers.push(marker);


                    });

			  
			
		});
	});
}
function initMap() {
var style = [{"featureType":"landscape","stylers":[{"saturation":-100},{"lightness":65},{"visibility":"on"}]},{"featureType":"poi","stylers":[{"saturation":-100},{"lightness":51},{"visibility":"simplified"}]},{"featureType":"road.highway","stylers":[{"saturation":-100},{"visibility":"simplified"}]},{"featureType":"road.arterial","stylers":[{"saturation":-100},{"lightness":30},{"visibility":"on"}]},{"featureType":"road.local","stylers":[{"saturation":-100},{"lightness":40},{"visibility":"on"}]},{"featureType":"transit","stylers":[{"saturation":-100},{"visibility":"simplified"}]},{"featureType":"administrative.province","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":-25},{"saturation":-100}]},{"featureType":"water","elementType":"geometry","stylers":[{"hue":"red"},{"lightness":-25},{"saturation":-97}]}];
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat : 46.3390728,lng :1.143419},
    zoom: 6,
 	draggable: true,
    styles: style
  });
  showMarkers();

}
google.maps.event.addDomListener(window, "load", initMap);
initMap();
