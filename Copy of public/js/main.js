﻿// Выполнение после загрузки на всех страницах
$(document).ready(function() {

	if ($('.sort_by_year span:first').text() != '') {
		start_year = $('.sort_by_year span:first').text();
		$('.teachers_pub_ul li').each(function(key, val) {
			$(val).find('span:contains(' + start_year + ')').parents('li').attr('class', 'showBlock');
		});
	}
	$('.pub_year').live("click", function() {
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
		}
	});
	$('.HideDisc').live("click", function(){
		$(this).parent().find('table').hide();
		$(this).html("дисциплины");
		$(this).removeClass('HideDisc');
		$(this).addClass('ShowDisc');
	});
	$('.ShowDisc').live("click", function(){
		$(this).parent().find('table').show();
		$(this).html("скрыть");
		$(this).removeClass('ShowDisc');
		$(this).addClass('HideDisc');
	});
	$('.show_child').click(function() {
		if ($(this).parent().find('ul').hasClass('hideBlock'))
			$(this).parent().find('ul').removeClass('hideBlock').addClass('showBlock');
		else
			$(this).parent().find('ul').removeClass('showBlock').addClass('hideBlock');
		return false;
	});
	$('.teacher_box .disciplines_href').click(function() {
		$('.disciplines_list_item').toggle("slow");
		return false;
	});
	$('.teacher_box .publications_href').click(function() {
		$('.publications_list_item').toggle("slow");
		return false;
	});
	
	/***
	 *
	 * abitur
	 * 
	 */
	$(".getStages").live("click", function(){
		this_ = $(this);
		
		level = $(this).parent('.instityte').attr("rel");
		$(this).parent().append("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
		$.ajax({
			type : "post",
			url : "/abiturients/getStages",
			data : {
				level : level
			}
		}).done(function(data) {
			this_.parent().find('.resultStages').html(data);
			$('.loading').remove();
		});
		return false;
	});
	$(".getStudy").live("click", function(){
		this_ = $(this);
		
		level = $(this).parents('.instityte').attr("rel");
		budget = $(this).parents('.budget').attr("rel");
		
		$(this).parent().append("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
		$.ajax({
			type : "post",
			url : "/abiturients/getStudyForms",
			data : {
				level : level,
				budget : budget
			}
		}).done(function(data) {
			this_.parent().find('.resultStudy').html(data);
			$('.loading').remove();
		});
		return false;
	});
	$(".getEducPlans").live("click", function(){
		this_ = $(this);

		level = $(this).parents('.instityte').attr("rel");
		budget = $(this).parents('.budget').attr("rel");
		studyform = $(this).parents('.studyForm').attr("rel");
		
		$(this).parent().append("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
		$.ajax({
			type : "post",
			url : "/abiturients/getEducPlans",
			data : {
				level : level,
				budget : budget,
				studyform : studyform
			}
		}).done(function(data) {
			this_.parent().find('.resultEducPlans').html(data);
			$('.loading').remove();
		});
		return false;
	});

	$(".getEntrantsInfo").live("click", function(){
		this_ = $(this);

		plan = $(this).parents('.plan').attr("rel");
		stage = $(this).parents('.stage').attr("rel");
		phase = 0;
		budget = $(this).parents('.budget').attr("rel");
		
		//phase - фаза приема ( 0 - пофамильный перечень, 1-рекомендованные, 2- включенные в приказ )
		$(this).parent().append("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
		
		$.ajax({
			type : "post",
			url : "/abiturients/getEntrantsInfo",
			data : {
				plan : plan,
				stage : stage,
				phase : phase,
				budget : budget
			}
		}).done(function(data) {
			this_.parent().find('.resultAbbiture').html(data);
			$('.loading').remove();
		});
		return false;
	});
	
	
	
});
