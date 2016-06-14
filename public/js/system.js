//----------------- Системные функции ----------
$loader = '<div class="loader"><img width="50px" src="/public/images/loader.gif" alt="Загрузка..." /></div>';
$loader_gray = '<div class="loader"><img src="/public/images/loader_gray.gif" alt="Загрузка..." /></div>';
// Показать диалог
$.showDialog = function (id) {
    $body_fill = $('#body_fill');
    // Показываем затемнение
    if ($('#body_fill').length==0) {
        $body_fill = $('<div id="body_fill"></div>');
        $('body').append($body_fill);
    }
    if ($('#'+id+':hidden').length>0) {
        $body_fill.css('opacity',0).show().animate({
            'opacity':0.5
        },0);
        // Показываем диалог
        //$('#'+id).css('top',100).show();
        
        $('.dialog_box:not(#'+id+')').fadeOut(0,function(){
        	$("#"+id).css({'margin-left': -($('#'+id).width())/2});
            $('#'+id).fadeIn(0);
        });
    }
};

// Показать диалог, содержимое которого загружается через ajax
$.showAjaxDialog = function (url,height,params,func) {
    $('#empty_dialog').css('height',height).find('.content').html($loader).find('.loader').css('marginTop',150);
    $.showDialog('empty_dialog');
    $.post(url,params, function(data){
        $('#empty_dialog .content').html(data);
        func();
    });
};

// Показать диалог
$.hideDialog = function (id) {
	var colDialog = $('.dialog:visible').length;
	if(colDialog>1){
		
	 $('#'+id).fadeOut(0);
	 }
	 else{
    $('#body_fill').animate({
        'opacity':0
    },0).hide();
    $('#'+id).fadeOut(0);
	}
};

$.hideAllDialogs = function () {
var colDialog = $('.dialog:visible').length;
	if(colDialog>1){
		
	 $('.dialog_box').fadeOut(0);
	 }
	 else{
    $('#body_fill').animate({
        'opacity':0
    },0).hide();
    $('.dialog_box,.mapdiller_box').fadeOut(0);
	}
};

// Изменить диалог
$.toggleDialog = function (id) {
    // Показываем диалог
    $('#'+id).css('top',100);
    $('.dialog:not(#'+id+')').fadeOut(0,function(){
        $('#'+id).fadeIn(0);
    });
};

// Показать сообщени
// error = 	Красный фон автоматически исчезает
// notice = Зеленый фон, закрывается вручную
// иначе = 	Зеленый фон, вывод информации

$.alert = function (message, type) {
	var id = '#message_dialog';
	$(id+' .text').html(message);
	var widthDialog =$(id).width();
	var heightDialog = $(id).height();
	
    if (typeof(alert_timeout)!='undefined') clearTimeout(alert_timeout);
	
	if (type =='notice'){
    	alert_timeout = false;
        $(id).css({ 'background':'white', 'color':'#000' });
        $(id+' .button').html("<a href='#' class='closeTop close_notice'><img src='/public/images/dialog-close.png'></a>");
        $('#message_dialog .button,#body_fill').show();
    }
    else if (type =='error'){
    	alert_timeout = setTimeout('$.hideDialog ("message_dialog")', 4000);
    	$(id+' .button').empty();
    	this_.css({'background':"url('/public/images/bg_error_red.jpg')" });
    }
    else {
    	alert_timeout = setTimeout('$.hideDialog ("message_dialog")', 4000);
    	$('#message_dialog .button').empty();
    	$(id).css({ 'background':'#009ce6', 'color':'#fff' });
    }

	$(id).css({'margin-top': (-heightDialog/2), 'margin-left': (-widthDialog/2) , 'width' : widthDialog});
    $.showDialog('message_dialog');

    $('#message_dialog .close_notice').click(function(){
    	$.hideDialog ("message_dialog");
    	return false;
    });
    $('.button').click(function(){
    	$(this).css({'padding':'2px'});
    	return false;
    });

};

// Выполнение после загрузки на всех страницах
$(document).ready(function () {
//    apply_styles ();
    check_anchor ();
});


// Применить стили CSS
function apply_styles () {
    if($.browser.opera)
     $('.rounded').corner('round 3px');
    $('.opacity').css('opacity','0.5');
    $('.clear_opacity').css('opacity','0');

}

function get_anchor () {
    hash = location.hash.substr(1);
    return hash;
}

function set_anchor (anchor) {
    location.href= '#'+anchor;
}
function remove_anchor () {
    location.href= '#';
}

function check_anchor () {
    anchor = get_anchor ();
    if (anchor != '') {
        set_page(anchor);
    }
    
}
function serialize( mixed_value ) {
    var _getType = function( inp ) {
        var type = typeof inp, match;
        var key;
        if (type == 'object' && !inp) {
            return 'null';
        }
        if (type == "object") {
            if (!inp.constructor) {
                return 'object';
            }
            var cons = inp.constructor.toString();
            if (match = cons.match(/(\w+)\(/)) {
                cons = match[1].toLowerCase();
            }
            var types = ["boolean", "number", "string", "array"];
            for (key in types) {
                if (cons == types[key]) {
                    type = types[key];
                    break;
                }
            }
        }
        return type;
    };
    var type = _getType(mixed_value);
    var val, ktype = '';
    switch (type) {
        case "function":
            val = "";
            break;
        case "undefined":
            val = "N";
            break;
        case "boolean":
            val = "b:" + (mixed_value ? "1" : "0");
            break;
        case "number":
            val = (Math.round(mixed_value) == mixed_value ? "i" : "d") + ":" + mixed_value;
            break;
        case "string":
            val = "s:" + mixed_value.length + ":\"" + mixed_value + "\"";
            break;
        case "array":
        case "object":
            val = "a";
            var count = 0;
            var vals = "";
            var okey;
            var key;
            for (key in mixed_value) {
                ktype = _getType(mixed_value[key]);
                if (ktype == "function") {
                    continue;
                }
                okey = (key.match(/^[0-9]+$/) ? parseInt(key) : key);
                vals += serialize(okey) +
                serialize(mixed_value[key]);
                count++;
            }
            val += ":" + count + ":{" + vals + "}";
            break;
    }
    if (type != "object" && type != "array") val += ";";
    return val;
}
$.fn.trim = function (){
    var o = {
        trim:new RegExp("^" + trim + "|" + trim + "$", "g"),
        trimLeft:new RegExp("^" + trim),
        trimRight:new RegExp(trim + "$")
    },  k;
    for(k in o)
        if(!String.prototype[k])
            String.prototype[k] = (function(trim){
                return function(){
                    return this.replace(trim, "");
                };
            })(o[k]);
    delete o;
    delete k;
};


function set_page (uri) {
    request = uri.split('/');
    page = request[1];
    action = request[2];
    id = request[2];
    
        $.get(uri, function(data) {
        //$('#content_block').html(data);
        //alert(uri+data);
        });
    
    
    

}


function mktime() {	// Get Unix timestamp for a date


	var i = 0, d = new Date(), argv = arguments, argc = argv.length;

	var dateManip = {
		0: function(tt){ return d.setHours(tt); },
		1: function(tt){ return d.setMinutes(tt); },
		2: function(tt){ return d.setSeconds(tt); },
		3: function(tt){ return d.setMonth(parseInt(tt)-1); },
		4: function(tt){ return d.setDate(tt); },
		5: function(tt){ return d.setYear(tt); }
	};

	for( i = 0; i < argc; i++ ){
		if(argv[i] && isNaN(argv[i])){
			return false;
		} else if(argv[i]){
			// arg is number, let's manipulate date object
			if(!dateManip[i](argv[i])){
				// failed
				return false;
			}
		}
	}

	return Math.floor(d.getTime()/1000);
}
