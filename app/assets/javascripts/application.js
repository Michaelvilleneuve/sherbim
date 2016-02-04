// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {	

	var $popup = $( '.popup' );
	var $button = $( '.btn-ask' );

	var target = $button.attr('data-link');
	$popup.children('.popup-content').load( target+'.js');

	$button.on('click', function() {
		$button.toggleClass('_active');
		$popup.toggleClass('_active');
	})
});

// Load map
$(document).on('page:load', function(){
	initMap();
});