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
var $document = $(document),
		$window = $(window),
		$body = $('body'),
		$notice = $('.notice');

$document.ready(function() {	

	var $popup = $( '.popup' );
	var $button = $( '.btn-ask' );

	var target = $button.attr('data-link');
	$popup.children('.popup-content').load( target+'.js');

	$button.on('click', function() {
		$button.toggleClass('_active');
		$popup.toggleClass('_active');

	});

	// Burger menu
	var $burger = $('.burger-menu'),
			$mainNav = $('.main-nav');

	// $burger.on('click', function() {
	// 	$burger.toggleClass('is-active');
	// 	$mainNav.toggleClass('is-visible');
	// });

	$window.on('scroll', function() {
		
		if ($window.scrollTop() > 40) {
			$mainNav.addClass('scroll');
		} else {
			$mainNav.removeClass('scroll');
		}
	});

	if ($notice.length > 0) {
		$notice.addClass('is-shown');
		setTimeout(function() {
			$notice.removeClass('is-shown');
		}, 3000);
	}
	
});

// Load map
$document.on('page:load', function(){
	initMap();
});
