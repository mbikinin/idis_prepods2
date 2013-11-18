$(document).ready(function(){

	$('.teacher_box .publications_href, .teacher_box .disciplines_href').click(function() {
		$(this).next().toggle();
		return false;
	});
	
	$('.pub_year').click(function() {
		if ($(this).attr("id") == 'active')
			return false
		else {
			year = $(this).attr("rel");
			$(this).parent().find('span').removeAttr("id");
			$(this).attr('id', 'active')
			if (year == "all") {
				$('.teachers_pub_ul li').each(function(key, val) {
					$(val).attr('class', 'showBlock');
				});
			} else {
				$('.teachers_pub_ul li').each(function(key, val) {
					if ($(val).find('span:contains(' + year + ')').parents('li').hasClass('hideBlock'))
						$(val).find('span').parents('li').attr('class', 'showBlock');
					else
						$(val).find('span').parents('li').attr('class', 'hideBlock');

				});
			}
			return false;
		}
		
	});
});
