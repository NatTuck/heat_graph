export var Dates = {
    localize_dates: function() {
        $('span.date').each(function(ii, ee) {
            var date = new Date($(ee).text().replace("Etc/", ""));
            var text = date.toString();
            if (text != "Invalid Date") {
                $(ee).text(text);
            }
        });
    }
}
