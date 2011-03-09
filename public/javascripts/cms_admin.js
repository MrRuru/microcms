$(document).ready(function(){
  
  $('a.edit_content').click(function(){
    form = $(this).closest('.content').find('.edit_content_form');
    $('#content_edition').find('#current_edition').html(form.html());
    $('#new_content_select').val( $("#new_content_select option:first").val() );
    return false;
  });
  
  $('#new_content_select').change(function(){
    form_id = $(this).find('option:selected').first().attr("id");
    $(this).siblings('.content_form').each(function(){$(this).hide();});
    $('#content_edition').find('#current_edition').html($(this).siblings('#'+form_id).html());
  });

});
