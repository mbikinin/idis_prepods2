﻿// Выполнение после загрузки на всех страницах
$(document).ready(function() {
	if ($('.sort_by_year span:first').text() != '') {
		start_year = $('.sort_by_year span:first').text();
		$('.teachers_pub_ul li').each(function(key, val) {
			$(val).find('span:contains(' + start_year + ')').parents('li').attr('class', 'showBlock');
		});
		return false;
	}
	$('.showBudget').live("click", function(){
		if($(this).parents('.phase').find('.s2').hasClass('hideBlock')){
			$(this).parents('.phase').find('.s2').removeClass('hideBlock');
			$(this).parents('.phase').find('.s2').addClass('showBlock');
		}
		
		else{
			$(this).parents('.phase').find('.s2').addClass('hideBlock');
			$(this).parents('.phase').find('.s2').removeClass('showBlock');
		}
		return false;
	});
	


	$('.HideDisc').live("click", function(){
		$(this).parent().find('table').hide();
		$(this).html("предметы");
		$(this).removeClass('HideDisc');
		$(this).addClass('ShowDisc');
		
		return false;
	});
	$('.ShowDisc').live("click", function(){
		$(this).parent().find('table').show();
		$(this).html("скрыть");
		$(this).removeClass('ShowDisc');
		$(this).addClass('HideDisc');
		return false;
	});
	$('.show_child').click(function() {
		if ($(this).parent().find('ul').hasClass('hideBlock'))
			$(this).parent().find('ul').removeClass('hideBlock').addClass('showBlock');
		else
			$(this).parent().find('ul').removeClass('showBlock').addClass('hideBlock');
		return false;
	});
	

	
	/***
	 *
	 * abitur
	 * 
	 */
	$(".getStages").live("click", function(){
		this_ = $(this);
		result = ".resultStages";
		if(this_.hasClass("is_load")){
			this_.parent().find(result).hide();
			this_.removeClass("is_load");
			this_.addClass("showBlock");
		}
		
		else if(this_.hasClass("showBlock")){
			this_.parent().find(result).show();
			this_.removeClass("showBlock");
			this_.addClass("is_load");
		}
		else{
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
			this_.addClass("is_load ")
			$('.loading').remove();
		});
		
		}
		return false;
	});

	$(".getStudy").live("click", function(){
		this_ = $(this);
		result = ".resultStudy";
		if(this_.hasClass("is_load")){
			this_.parent().find(result).hide();
			this_.removeClass("is_load");
			this_.addClass("showBlock");
			return false;
		}
		else if(this_.hasClass("showBlock")){
			this_.parent().find(result).show();
			this_.removeClass("showBlock");
			this_.addClass("is_load");
			return false;
		}
		else{
		level = $(this).parents('.instityte').attr("rel");
		budget = $(this).parents('.budget').attr("rel");
		free = $(this).parents('.budget').hasClass("free") ? 1 : 0;
		$(this).parent().append("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
		$.ajax({
			type : "post",
			url : "/abiturients/getStudyForms",
			data : {
				level : level,
				budget : budget,
				free : free
			}
		}).done(function(data) {
			this_.parent().find('.resultStudy').html(data);
			this_.addClass("is_load ")
			$('.loading').remove();
		});
		
		}
		return false;
	});
	$(".getEducPlans").live("click", function(){
		this_ = $(this);
		result = ".resultEducPlans";
		if(this_.hasClass("is_load")){
			this_.parent().find(result).hide();
			this_.removeClass("is_load");
			this_.addClass("showBlock");
		}
		else if(this_.hasClass("showBlock")){
			this_.parent().find(result).show();
			this_.removeClass("showBlock");
			this_.addClass("is_load");
		}
		else{
		level = $(this).parents('.instityte').attr("rel");
		budget = $(this).parents('.budget').attr("rel");
		studyform = $(this).parents('.studyForm').attr("rel");
		free = $(this).parents('.budget').hasClass("free") ? 1 : 0;

		$(this).parent().append("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
		$.ajax({
			type : "post",
			url : "/abiturients/getEducPlans",
			data : {
				level : level,
				budget : budget,
				studyform : studyform,
				free : free
			}
		}).done(function(data) {
			this_.parent().find('.resultEducPlans').html(data);
			this_.addClass("is_load ")
			$('.loading').remove();
		});
		
		}
		return false;
	});

	$(".getEntrantsInfo").live("click", function(){
		this_ = $(this);
		result = ".resultAbbiture";
		if(this_.hasClass("is_load")){
			this_.parent().find(result).hide();
			this_.parent().find(".kvotaplaces").hide();
			this_.removeClass("is_load");
			this_.addClass("showBlock");
			return false;
		}
		else if(this_.hasClass("showBlock")){
			this_.parent().find(result).show();
			this_.removeClass("showBlock");
			this_.parent().find(".kvotaplaces").css({"display": "block"}).show();
			this_.addClass("is_load");
			return false;
		}
		else{
		plan = $(this).parents('.plan').attr("rel");
		stage = $(this).parents('.stage').attr("rel");
		phase = $(this).parents('.phase').attr("rel");
		budget = $(this).parents('.budget').attr("rel");
		budgetplaces = $(this).parent().find('.budgetplaces').attr("value");
		free = $(this).parents('.budget').hasClass("free") ? 1 : 0;
		inst = this_.parents('.instityte').attr("rel");

			//phase - фаза приема ( 0 - пофамильный перечень, 1-рекомендованные, 2- включенные в приказ )
		$(this).parent().append("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
		
		$.ajax({
			type : "post",
			url : "/abiturients/getEntrantsInfo",
			data : {
				plan : plan,
				stage : stage,
				phase : phase,
				budget : budget,
				budgetplaces : budgetplaces,
				free : free,
				inst : inst
			}
		}).done(function(data) {
			this_.parent().find('.resultAbbiture').html(data);
			this_.addClass("is_load ")
			
			this_.parent().find(".kvotaplaces").css({"display": "block"}).show();
			
			$('.loading').remove();
		});
		
		}
		return false;
	});
	$(".getEntrantsInfo2").live("click", function(){

		this_ = $(this);
		result = ".resultAbbiture";
		if(this_.hasClass("is_load")){
			this_.parent().find(result).hide();
			this_.parents('.getEducPlans').find(".kvotaplaces2").hide();
			this_.removeClass("is_load");
			this_.addClass("showBlock");
			return false;
		}
		else if(this_.hasClass("showBlock")){
			this_.parent().find(result).show();
			this_.removeClass("showBlock");
			this_.parent('.getEducPlans').find(".kvotaplaces2").css({"display": "block"}).show();
			this_.addClass("is_load");
			return false;
		}
		else{

		plan = this_.parents('.plan').attr("rel");
		stage = this_.parents('.stage').attr("rel");

		phase = this_.attr("rel");
		budget = this_.parents('.budget').attr("rel");
		budgetplaces = this_.parent().find('.budgetplaces').attr("value");

		free = this_.parents('.budget').hasClass("free") ? 1 : 0;
		inst = this_.parents('.instityte').attr("rel");
		//phase - фаза приема ( 0 - пофамильный перечень, 1-рекомендованные, 2- включенные в приказ )
		$(this).parent().append("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
		
		$.ajax({
			type : "post",
			url : "/abiturients/getEntrantsInfo",
			data : {
				plan : plan,
				stage : stage,
				phase : phase,
				budget : budget,
				budgetplaces : budgetplaces,
				free : free,
				inst : inst
			}
		}).done(function(data) {
			this_.parent().find('.resultAbbiture').html(data);
			this_.addClass("is_load ")
			
			this_.parent().find(".kvotaplaces").css({"display": "block"}).show();
			
			$('.loading').remove();
		});
		
		}
		return false;
	});

	$(".getEntrantsInfo3").live("click", function(){

		this_ = $(this);
		result = ".resultAbbiture";
		if(this_.hasClass("is_load")){
			this_.parent().find(result).hide();
			this_.parents('.getEducPlans').find(".kvotaplaces2").hide();
			this_.removeClass("is_load");
			this_.addClass("showBlock");
			return false;
		}
		else if(this_.hasClass("showBlock")){
			this_.parent().find(result).show();
			this_.removeClass("showBlock");
			this_.parent('.getEducPlans').find(".kvotaplaces2").css({"display": "block"}).show();
			this_.addClass("is_load");
			return false;
		}
		else{

			plan = this_.parents('.plan').attr("rel");
			stage = this_.parents('.stage').attr("rel");

			phase = this_.attr("rel");
			budget = this_.parents('.budget').attr("rel");
			budgetplaces = this_.parent().find('.budgetplaces').attr("value");

			free = this_.parents('.budget').hasClass("free") ? 1 : 0;
			inst = this_.parents('.instityte').attr("rel");
			//phase - фаза приема ( 0 - пофамильный перечень, 1-рекомендованные, 2- включенные в приказ )
			$(this).parent().append("<div class='loading'><img src = '/public/images/loader.gif'/></div>");

			$.ajax({
				type : "post",
				url : "/abiturients/getEntrantsInfo",
				data : {
					plan : plan,
					stage : 641,
					phase : phase,
					budget : budget,
					budgetplaces : budgetplaces,
					free : free,
					inst : inst
				}
			}).done(function(data) {
				this_.parent().find('.resultAbbiture').html(data);
				this_.addClass("is_load ")

				this_.parent().find(".kvotaplaces").css({"display": "block"}).show();

				$('.loading').remove();
			});

		}
		return false;
	});

	$(".getEntrantsInfoList").live("click", function(){

		this_ = $(this);
		result = ".resultAbbiture";
		if(this_.hasClass("is_load")){
			this_.parent().find(result).hide();
			this_.parent().find(".kvotaplaces").hide();
			this_.removeClass("is_load");
			this_.addClass("showBlock");
			return false;
		}
		else if(this_.hasClass("showBlock")){
			this_.parent().find(result).show();
			this_.removeClass("showBlock");
			this_.parent().find(".kvotaplaces").css({"display": "block"}).show();
			this_.addClass("is_load");
			return false;
		}
		else{
		plan = $(this).parents('.plan').attr("rel");
		stage = $(this).parents('.stage').attr("rel");
		phase = $(this).parents('.phase').attr("rel");
		budget = $(this).parents('.budget').attr("rel");
		budgetplaces = $(this).parent().find('.budgetplaces').attr("value");
		free = $(this).parents('.budget').hasClass("free") ? 1 : 0;
		inst = this_.parents('.instityte').attr("rel");
		orderDate = $('.orderDate').val();

			//phase - фаза приема ( 0 - пофамильный перечень, 1-рекомендованные, 2- включенные в приказ )
		$(this).parent().append("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
		$.ajax({
			type : "post",
			url : "/abiturients/getEntrantsInfoList",
			data : {
				phase : phase,
				inst : inst,
				free : free,
				budget : budget,
				orderDate : orderDate
			}
		}).done(function(data) {
			this_.parent().find('.resultAbbiture').html(data);
			this_.addClass("is_load ")
			
			this_.parent().find(".kvotaplaces").css({"display": "block"}).show();
			
			$('.loading').remove();
		});	
		}
		return false;
	});
	
	
	
});
