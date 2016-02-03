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
//= require turbolinks
//= require_tree .

// Pop up envoyer une demande de service
// $(document).on('click','a',function(event){
// 	event.preventDefault();
// 	link = $(this).attr('href');
// 	$("#wait").fadeIn(900,function(){;
// 		$("#content").hide();
// 		Turbolinks.visit(link);
// 	});
// })

$( document ).ready(function() {

	var popup = $( ".popup" );
	var button = $( ".btn-ask" );
	var popupClose = $('.popup-close');

	function openPopup(){
		popup.addClass('_active');
		button.addClass('is-active');
	}
	function closePopup(){
		popup.removeClass('_active');
		button.removeClass('is-active');
	}
	button.click(function() {
		var target = $(this).attr('data-link');
		$('.popup-content').load( target+'.js',  openPopup);
	});
	popupClose.click(function() {
		closePopup();
	});
	$(document).mouseup(function (e){
		var popupContent = $( ".popup-content" )
		if (!popupContent.is(e.target) && popupContent.has(e.target).length === 0) {
			closePopup();
		}
	});
});

