$ ->
  $.ajax "<%= root_path %>",
    dataType: 'script',
    error: (jqXHR, textStatus, errorThrown) ->
      alert textStatus
    success: (data, textStatus, jqXHR) ->
      console.log(data)
      $('#form_section').empty().append(data)
