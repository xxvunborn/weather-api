App.room = App.cable.subscriptions.create "WeathersChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when the subscription has been terminated by the server
    cities_data = data['message']

    for key, value of cities_data
      $('#'+key+'-temperature').text(value.temperature + '˚')
      $('#'+key+'-sumary').text(value.summary)
      $('#'+key+'-humidity').text(value.humidity)
      $('#'+key+'-windspeed').text(value.windSpeed)
      $('#'+key+'-uvindex').text(value.uvIndex)
      $('#'+key+'-visibility').text(value.visibility)
      $('#'+key+'-pressure').text(value.pressure)
      $('#'+key+'-time').text(value.time)
