		
// Выполнение после загрузки на всех страницах
$(document).ready(function () {
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
