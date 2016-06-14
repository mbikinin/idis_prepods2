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

        $(this).parent().append("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
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

    $(".getResultList").live("change", function(){
        url = 0;
        id = $(this).val();
        url = id == 1 ? 'getEntrantsSubmitDocuments' :'getEntrantsList';

        this_ = $(this);
        result = ".resultList";

        _branch = $('.branch').val();
        _speccode = $('.speccode').val();
        _skillid = $('.speccode_'+_speccode).attr("rel");
        _studyform = $('.studyform').val();
        _financeform = $('.financeform').val();
        _krim = $('.krim').is(':checked') ? 1 : 0;
        alert(_speccode)
        $(this_).parent().append("<div class='loading'><img src = '/public/images/loader.gif'/></div>");
        $.ajax({
            type : "post",
            url : "/ratings/"+ url,
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
});
