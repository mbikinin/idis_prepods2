		
// Выполнение после загрузки на всех страницах
$(document).ready(function () {
	
	if($('.sort_by_year span:first').text() != ''){
		start_year = $('.sort_by_year span:first').text();
		$('.teachers_pub_ul li').each(function(key, val) {
			$(val).find('span:contains('+start_year+')').parents('li').attr('class','showBlock'); 
		});		
	}
	$('.pub_year').click(function(){
		year = $(this).attr("rel");
		$(this).parent().find('span').removeAttr("id");
		$(this).attr('id','active')
		if(year == "all"){
			$('.teachers_pub_ul li').each(function(key, val) {
				if($(val).hasClass('hideBlock'))
					$(val).attr('class','showBlock');
			});
		}
		else{
			$('.teachers_pub_ul li').each(function(key, val) {
				if($(val).find('span:contains('+year+')').parents('li').hasClass('hideBlock'))
					$(val).find('span:contains('+year+')').parents('li').attr('class','showBlock');
				else
					$(val).find('span').parents('li').attr('class','hideBlock');
					
			});
		}
	});
			
	$('.show_child').click(function(){
		if($(this).parent().find('ul').hasClass('hideBlock'))
			$(this).parent().find('ul').removeClass('hideBlock').addClass('showBlock');
		else $(this).parent().find('ul').removeClass('showBlock').addClass('hideBlock');
		return false;
	});
	$('.teacher_box .disciplines_href').click(function () {
		$('.disciplines_list_item').toggle("slow");
		return false;
	});
	$('.teacher_box .publications_href').click(function () {
		$('.publications_list_item').toggle("slow");
		return false;
	});
});
