// Выполнение после загрузки на всех страницах
function loading(){
    $('.progress_box').html("<div class='loading'><div class='bg'></div><img src = '/public/images/loader.gif'/></div>");
}
$(document).ready(function() {
    $('body').on("change", ".getRatingEducPlans", function(){
        this_ = $(this);
        result = ".resultEducPlans";

        _branch = $('.branch').val();
        _studyform = $('.studyform').val();
        _financeform = $('.financeform').val()
        _skillvalue = $('.skillvalue').val();
        //$('.speccode').addClass('hide')
        $('.resultEducPlans').html("<div class='loading'><div class='bg'></div><img src = '/public/images/loader.gif'/></div>");

        //loading();
        $.ajax({
            type : "post",
            url : "/ratings/getEducPlans",
            data : {
                branch : _branch,
                studyform : _studyform,
                financeform : _financeform,
                skillvalue : _skillvalue
            }
        }).done(function(data) {
            this_.parent().find('.resultEducPlans').html(data);
            $('.loading').remove();
        });
        return false;
    });

    $(".getResultList").click( function(){
        this_ = $(this);
        result = ".resultList";
        var list_type = $('.list_type').val();
        switch(list_type){
            case "1":
                _url = 'getEntrantsSubmitDocuments';
                break;
            case "2":
                _url = 'getEntrantsList';
                break;
            case "3":
                _url = 'getExamsList';
                break;
            case "4":
                _url = 'getOrders';
                break;
        }

        _branch = $('.branch').val();
        _speccode = $('.speccode').val();
        _skillid = $('.speccode').find(':selected').attr('rel');
        _skillvalue = $('.skillvalue').val();
        _studyform = $('.studyform').val();
        _financeform = $('.financeform').val();
        _kvota = $('.kvota_type').val();

        if(!validate()) {
            $.alert({
                title: 'Внимание!',
                content: "Необходимо выбрать все поля",
            });
            return false;
        }

        loading();
        $.ajax({
            type : "post",
            url : "/ratings/"+ _url,
            data : {
                branch : _branch,
                skillid : _skillid,
                skillvalue : _skillvalue,
                speccode : _speccode,
                studyform : _studyform,
                financeform : _financeform,
                kvota : _kvota
            }
        }).done(function(data) {
            this_.parent().find('.resultList').html(data);
            $('.loading').remove();
        });
        return false;
    });

    $('body').on("change", 'select', function(){
        $(this).val() != -1 ?
            $(this).removeClass('error') :
            $(this).addClass('error')
    });
    $('body').on("change", '.reset_financeform', function(){
        $('.financeform').val("-1")
    });

    $('body').on("change", '.reset_educplans', function(){
        $('.speccode').val("-1")
    });

    $('body').on("change", '.inf_reset_skill', function(){
        $('.skillvalue').val("-1")
    });

    $('body').on("change", '.list_type', function(){
        $(this).val() == 2 && $('.financeform').val() == 2 && $('.skillvalue').val() != 4 ?
            $('.kvota_type').removeClass('hide'):
            $('.kvota_type').addClass('hide')
    })


    //Get information Educ plans list
    $('body').on("change", ".getInfoEducPlans", function(){
        this_ = $(this);
        result = ".resultEducPlans";
        _branch = $('.branch').val();
        _skillvalue = $('.skillvalue').val();
        if(_branch < 0 ) {
            $.alert({
                title: 'Внимание!',
                content: "Необходимо выбрать город",
            });
            return false;
        }

        $.ajax({
            type : "post",
            url : "/ratings/getInfoEducPlans",
            data : {
                branch : _branch,
                skillvalue : _skillvalue
            }
        }).done(function(data) {
            this_.parent().find('.resultEducPlans').html(data);
            $('.loading').remove();
        });
        return false;
    });

    $(".getInfoRatingList").click( function(){
        this_ = $(this);
        result = ".resultList";

        _branch = $('.branch').val();
        _speccode = $('.speccode').find(':selected').attr('rel');
        _skillvalue = $('.skillvalue').val();
        if(!validate()) {
            $.alert({
                title: 'Внимание!',
                content: "Необходимо выбрать все поля!",
            });
            return false;
        }
        loading();
        $.ajax({
            type : "post",
            url : "/ratings/getInformationRating",
            data : {
                branch : _branch,
                speccode : _speccode,
                skillvalue : _skillvalue
            }
        }).done(function(data) {
            this_.parent().find('.resultList').html(data);
            $('.loading').remove();
        });

        return false;
    });


    //Get information list

});
function validate(){
    result = 0
    $.each($('.rating_box select'), function(key, value) {
        if(($(this).val()) == '-1' && $(this).is(':not(:hidden)')) {
            $(this).addClass('error')
            result++;
        }
        else {
            $(this).removeClass('error')
        }
    });
    return result == 0
}