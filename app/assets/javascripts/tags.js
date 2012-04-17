$(function() {
    $(document).on('click', '#new-tag-link', function(e) {
        e.preventDefault();
        $('#new-tag-link').hide();
        $('#new-tag-name').show().focus();
    });

    $(document).on('ajax:success', '#new-tag-form', function(event, data) {
        if(data) {
            var tagHtml = '<a href="/tags/'
                + data.id + '"><span class="label label-info">' + data.name
                + '</span></a>';
            $('#taggings').append(tagHtml);
            $('#new-tag-name').hide().val('');
            $('#new-tag-link').show();
        }
    });
});