// Place your application-specific JavaScript functions and classes here

/* For debugging ... */
function print_r(theObj){
	if(theObj.constructor == Array || theObj.constructor == Object){
		document.write("<ul>")
		for(var p in theObj){
			if(theObj[p].constructor == Array || theObj[p].constructor == Object){
				document.write("<li>["+p+"] => "+typeof(theObj)+"</li>");
				document.write("<ul>")
				print_r(theObj[p]);
				document.write("</ul>")
			} else {
				document.write("<li>["+p+"] => "+theObj[p]+"</li>");
			}
		}
		document.write("</ul>")
	}
}

/* Let the flash message disappear ... */
function flash_fadeout() {
	clearTimeout($.data(document.body, 'flash_timer'));
	$.data(document.body, 'flash_timer', setTimeout(function() {
	      $('#flash').stop(true, true).fadeOut('slow');
	  }, 4000));
}

/* As soon as the page is ready ... */
$(document).ready(function () {
	
	/* Highlight / fade out the flash message */
	$('#flash.error').add('#flash.alert').effect('shake', {distance: 5, times: 2}, 100);
	if ($('#flash.success').add('#flash.notice').length == 1) { flash_fadeout(); }

	/* Orders from the front page */
	$(".menu_item a").bind("click", function() {$(this).parent().toggleClass("loading");});
	$(".menu_item a").bind("ajax:success", function(event, data, status, xhr) {
		$('#menu_item_' + data.id).children('a').html(data.name);
		//$('#menu_item_' + data.id).children('span').html(data.after_name);
		$(this).closest('div').find('.orders_per_day').html('(' + data.orders_per_day + ')');
		$('#menu_item_' + data.id).removeClass().addClass("menu_item").addClass(data.status);
		$('#flash').removeClass().addClass(data.flash_status).html(data.flash_message).show();
		flash_fadeout();
	});
	
	/* Edit the menu items */
	// Click to edit
	$('.editable_menu_item span.click_to_edit').bind("click", function () {
		$(this).hide();
		$(this).siblings(':text').show().focus();
	});
	// Submit on blur
	// $('.editable_menu_item :text').bind("blur", function () {
	// 	if ($(this).val() != "") {
	// 		$(this).closest('form').submit();
	// 	}
	// });
	// Change to text after submit and focus next text input
	$('form.new_menu_item').bind("submit", function () {
		$(this).find(':text').hide();
		$(this).find('span.click_to_edit').html($(this).find(':text').val()).removeClass("status_ok").show();
		if ($(this).next().find(':text:visible').focus().length == 0) $(this).closest('div').next().find(':text:visible').first().focus();
		$('.ui-autocomplete').hide();
	});
	// Success indicator
	$("form.new_menu_item").bind("ajax:success", function(event, data, status, xhr) {
		$(this).find('span.click_to_edit').html(data.name);
		$(this).find('span.click_to_edit').addClass("status_" + data.status);
	});
	
});