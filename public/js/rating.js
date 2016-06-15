// Выполнение после загрузки на всех страницах
$(document).ready(function() {
    $(".getRatingEducPlans").live("change", function(){
        this_ = $(this);
        result = ".resultEducPlans";

        _branch = $('.branch').val();
        _studyform = $('.studyform').val();
        _financeform = $('.financeform').val()
        _skillvalue = $('.skillvalue').val();
        _financeform = $('.financeform').val();

        $('.progress_box').html("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
        $.ajax({
            type : "post",
            url : "/ratings/getEducPlans",
            data : {
                branch : _branch,
                studyform : _studyform,
                financeform : _financeform,
                skillvalue : _skillvalue,
                financeform : _financeform
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

        _url = $('.list_type').val() == '1' ? 'getEntrantsSubmitDocuments' :'getEntrantsList';
        _branch = $('.branch').val();
        _speccode = $('.speccode').val();
        _skillid = $('.speccode_'+_speccode).attr("rel");
        _studyform = $('.studyform').val();
        _financeform = $('.financeform').val();
        _krim = $('.krim').val();
        if(!validate()) {
            alert("Необходимо выбрать все поля!")
            return false;
        }
        $('.progress_box').html("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
        $.ajax({
            type : "post",
            url : "/ratings/"+ _url,
            data : {
                branch : _branch,
                skillid : _skillid,
                speccode : _speccode,
                studyform : _studyform,
                financeform : _financeform,
                krim : _krim
            }
        }).done(function(data) {
            this_.parent().find('.resultList').html(data);
            $('.loading').remove();
        });

        return false;
    });

    $('.reset_financeform').live("change", function(){
        $('.financeform').val("-1")
    })

});
function validate(){
    result = 0
    $.each($('.rating_box select'), function(key, value) {
        if(($(this).val()) == '-1') {
            $(this).addClass('error')
            result++;
        }
        else {
            $(this).removeClass('error')
        }
    });
    return result == 0
}