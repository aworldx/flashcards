$ ->
  $('#form_section').empty()
  .append("<%= j render 'home/form', locals: { card: nil } %>")
