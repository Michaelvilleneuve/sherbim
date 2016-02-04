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
// require_tree .

$(document).ready(function() {	

	var $popup = $( '.popup' );
	var $button = $( '.btn-ask' );

	var target = $button.attr('data-link');
	$popup.children('.popup-content').load( target+'.js');

	$button.on('click', function() {
		$button.toggleClass('_active');
		$popup.toggleClass('_active');
	})

	// function openPopup(){
	// 	popup.addClass('_active');
	// 	button.addClass('_active');
	// }

	// function closePopup(){
	// 	popup.removeClass('_active');
	// 	button.removeClass('_active');
	// }

	// button.on('click', function() {
	// 	var target = $(this).attr('data-link');
	// 	if(!popup.hasClass('_active')){
	// 		$('.popup-content').load( target+'.js',  openPopup);
	// 	}else{
	// 		closePopup();
	// 	}
	// });

	// popupClose.click(function() {
	// 	closePopup();
	// });

	// if(!popup.hasClass('_active')){
	// 	$(document).mouseup(function (e){
	// 		var popupContent = $( '.popup-content' )
	// 		if (!popupContent.is(e.target) && popupContent.has(e.target).length === 0
	// 			&& !popupClose.is(e.target) && popupClose.has(e.target).length === 0) {
	// 			closePopup();
	// 	}
	// });
	// }
});

// Load map
$(document).on('page:load', function(){
	initMap();
});