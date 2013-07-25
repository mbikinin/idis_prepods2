Calendar.LANG("ru", "русский", {

        fdow: 1,                // first day of week for this locale; 0 = Sunday, 1 = Monday, etc.

        goToday: "Сегодня",

        today: "Сегодня",         // appears in bottom bar

        wk: "нед",

        weekend: "0,6",         // 0 = Sunday, 1 = Monday, etc.

        AM: "am",

        PM: "pm",

        mn : [ "январь",
               "февраль",
               "март",
               "апрель",
               "май",
               "июнь",
               "июль",
               "август",
               "сентябрь",
               "октябрь",
               "ноябрь",
               "декабрь" ],

        smn : [ "янв",
                "фев",
                "мар",
                "апр",
                "май",
                "июн",
                "июл",
                "авг",
                "сен",
                "окт",
                "ноя",
                "дек" ],

        dn : [ "воскресенье",
               "понедельник",
               "вторник",
               "среда",
               "четверг",
               "пятница",
               "суббота",
               "воскресенье" ],

        sdn : [ "вск",
                "пон",
                "втр",
                "срд",
                "чет",
                "пят",
                "суб",
                "вск" ]

});

Calendar.setup({
    cont          : "calendar-container",
    weekNumbers   : false,
    selectionType : Calendar.SEL_MULTIPLE,
    selection     : Calendar.dateToInt(new Date()),
    showTime      : false,
    onSelect      : function() {
        var count = this.selection.countDays();
        if (count == 1) {
            var date = this.selection.get()[0];
            date = Calendar.intToDate(date);
            date = Calendar.printDate(date, "%A, %B %d, %Y");
            $("calendar-info").innerHTML = date;
        } else {
            $("calendar-info").innerHTML = Calendar.formatString(
                "${count:no date|one date|two dates|# dates} selected",
                { count: count }
            );
        }
    },
    onTimeChange  : function(cal) {
        var h = cal.getHours(), m = cal.getMinutes();
        // zero-pad them
        if (h < 10) h = "0" + h;
        if (m < 10) m = "0" + m;
        $("calendar-info").innerHTML = Calendar.formatString("Time changed to ${hh}:${mm}", {
            hh: h,
            mm: m
        });
    }
});

