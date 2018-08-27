# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->

  cdd = new CSSC

  $('#callback').on 'change', (e) ->
    slackButton = document.getElementById("add_slack_webhook")
    emailButton = document.getElementById("add_email_receiver")
    callbackForm = document.getElementById("callback_form")

    if e.target.value is 'email'
      emailButton.style.display = "block"
      slackButton.style.display = "none"
      clearFormGroup()
      createEmailForm()
    else if e.target.value is 'slack'
      slackButton.style.display = "block"
      emailButton.style.display = "none"
      clearFormGroup()
      createSlackForm()
    else
      emailButton.style.display = "none"
      slackButton.style.display = "none"
      clearFormGroup()


  $('#add_email_receiver').on 'click', (e) ->
    createEmailForm()

  $('#add_slack_webhook').on 'click', (e) ->
    createSlackForm()

  @deleteReceiver = (id) ->
    element = document.getElementById(id)
    callbackForm = document.getElementById("callback_form")
    callbackForm.removeChild(element)

  createEmailForm = () ->
    callbackForm = document.getElementById("callback_form")
    idx = callbackForm.childElementCount

    receiverInputGroup = document.createElement('div')
    receiverInputGroup.id = "inputGroup" + idx

    receiverField = document.createElement('input')
    receiverField.placeholder = 'Receiver Email'
    receiverField.id = "receiverField_" + idx
    receiverField.name = "receiver[]"
    receiverField.required = true
    receiverField.type = "email"

    deleteButton = document.createElement('span')
    deleteButton.innerText = 'Delete'
    deleteButton.className = 'btn btn-danger'
    deleteButton.addEventListener('click', ->
      element = document.getElementById(receiverInputGroup.id)
      callbackForm = document.getElementById("callback_form")
      callbackForm.removeChild(element)
    )

    receiverInputGroup.appendChild(receiverField)
    receiverInputGroup.appendChild(deleteButton)

    callbackForm.appendChild(receiverInputGroup)

  createSlackForm = () ->
    callbackForm = document.getElementById("callback_form")
    idx = callbackForm.childElementCount

    receiverInputGroup = document.createElement('div')
    receiverInputGroup.id = "inputGroup" + idx

    receiverField = document.createElement('input')
    receiverField.placeholder = 'Slack Webhook URL'
    receiverField.id = "receiverField_" + idx
    receiverField.name = "receiver[]"
    receiverField.required = true

    deleteButton = document.createElement('div')
    deleteButton.innerText = 'Delete'
    deleteButton.className = 'btn btn-danger'
    deleteButton.addEventListener('click', ->
      element = document.getElementById(receiverInputGroup.id)
      callbackForm = document.getElementById("callback_form")
      callbackForm.removeChild(element)
    )

    receiverInputGroup.appendChild(receiverField)
    receiverInputGroup.appendChild(deleteButton)

    callbackForm.appendChild(receiverInputGroup)

  clearFormGroup = () ->
    callbackForm = document.getElementById("callback_form")
    callbackForm.innerText = ""
    receiverCount = 0