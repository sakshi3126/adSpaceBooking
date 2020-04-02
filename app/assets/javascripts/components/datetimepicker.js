$(document).on('turbolinks:load', function() {
    $('body').on('click', '[data-toggle="datepicker"]', function() {
        if (!$(this).data('daterangepicker')) {
            $(this).daterangepicker({
                singleDatePicker: true,
                showDropdowns: true,
                opens: $(this).data('direction') ? $(this).data('direction') : "left",
                locale: {
                    format: 'DD-MMM-YYYY'
                }
            }).focus();
        }
    });

});
