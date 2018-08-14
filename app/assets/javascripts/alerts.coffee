# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  receiver_count = 0

  $('#alert_callback').on 'change', (e) ->
    if e.target.value is 'email'
      add_button = document.getElementById("add_button")
      add_button.style.display = "block"
    else
      console.log("nothing")

  $('#add_button').on 'click', (e) ->
    callback_form = document.getElementById("callback_form")

    receiver_input_group = document.createElement('div')
    receiver_input_group.id = "input_group" + receiver_count

    receiver_field = document.createElement('input')
    receiver_field.placeholder = 'Receiver Email ' + receiver_count
    receiver_field.id = "receiver_field_" + receiver_count
    receiver_field.name = "receiver[]"

    delete_button = document.createElement('div')
    delete_button.innerText = '-'
    delete_button.addEventListener('click', ->
      delete_receiver(receiver_input_group.id)
    )

    receiver_count++

    receiver_input_group.appendChild(receiver_field)
    receiver_input_group.appendChild(delete_button)

    callback_form.appendChild(receiver_input_group)

  delete_receiver = (id) ->
    element = document.getElementById(id)
    callback_form = document.getElementById("callback_form")
    callback_form.removeChild(element)
