$(document).ready(function(){

  var edit_form = $('#content_edition_form');

  $('textarea.editor').ckeditor();

  // Update the fields (name and translations) for a content
  function update_fields_values(content_id){
    // Find the field values
    fields_block = $("#content_list").find(".cms_content_fields[content_id='"+content_id+"']").first();
    
    // Get the values
    name = fields_block.find('.content_name').first().html();
    var translations = new Object();
    fields_block.find('.content_translation').each(function(){
      // alert('found translation' + $(this).html());
      translations[$(this).attr("locale")] = $('<div/>').html($(this).html()).text();
    });
            
    // Set them in the edit form
    edit_form.find("input[name='cms_content[name]']").val(name);
    edit_form.find(".locale_block").each(function(){
      $(this).find('textarea').first().val(translations[$(this).attr("locale")]);
    });
      
    // Set the url the form points to
    edit_form.attr('action', fields_block.attr('form_url'));
  }
    
  
  $('a.edit_content_link').click(function(){
    $('.edit_content').show();
    $('.new_content').hide();
    update_fields_values($(this).attr('content_id'));
  });
  
  
  $('a#new_content').click(function(){
    $('.edit_content').hide();
    $('.new_content').show();

    // Clear the form
    edit_form.find("input[name='cms_content[name]']").val('');
    edit_form.find(".locale_block textarea").val('');
    
    // Set the form url
    edit_form.attr('action', $(this).attr('form_url'));
  });

  $('a.show_locale').live('click',function(){
    // Find the refered locale
    locale = $(this).attr("locale");
    
    // Toggle the link classes
    $('a.show_locale').removeClass('active');
    $(this).addClass('active');

    // Toggle the locale blocks visibility
    $('.locale_block[locale != "'+locale+'"]').hide();
    $('.locale_block[locale = "'+locale+'"]').show();
    
    return false;
  });

  $('a#new_page').click(function(){
    if( $('#new_page_form').is(':visible') ) {
      $('#new_page_form').hide();
      $('a#new_page').removeClass('active');      
    }
    else{
      $('#new_page_form').show();
      $('a#new_page').addClass('active');
    }
    
    return false;
  });
  
});
