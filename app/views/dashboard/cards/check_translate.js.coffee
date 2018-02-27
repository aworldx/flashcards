$ ->
  $("#form_section").empty()
  .append("<%= j render partial: 'home/form', locals: { card: @card, message: @message } %>")
