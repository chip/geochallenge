class Map
  constructor: (latitude, longitude) ->
    @latitude  = latitude
    @longitude = longitude
    @map       = ''
    @marker    = ''

  load: ->
    if GBrowserIsCompatible()
      @map = new GMap2(document.getElementById("map_canvas"))
      coordinates = new GLatLng(@latitude, @longitude)
      @map.setCenter(coordinates, 8);
      @marker = new GMarker(coordinates)
      @map.setUIToDefault()

  add_marker: ->
    @map.addOverlay(@marker)

class CountryCapital
  constructor: (country_data) ->
    @country_data = country_data
    @answers = {}
    @country = ''
    @capital = ''
    @map     = ''

  random: (length) ->
    Math.floor(Math.random()*length)

  ask: ->
    countries = Object.keys(@country_data)
    index = @random(countries.length)
    country = countries[index]
    @country = @country_data[country]
    @capital = @country.capital
    console.log("lat:" + @country.latitude + " long:" + @country.longitude)
    console.log("country: #{country}")
    console.log("capital: #{@capital}")
    @map = new Map(@country.latitude, @country.longitude)
    @map.load()

    $('#question').html "What is the capital of #{country}?"

jQuery ->
  country_capital = new CountryCapital(country_data)
  country_capital.ask()

  $('#submit').click ->
    $('#answer').html ''
    users_answer = $('#users_answer').val().toLowerCase()
    capital = country_capital.capital.toLowerCase()
    if users_answer == capital
      $('#answer').css(color: 'green').html 'CORRECT'
      country_capital.map.add_marker()
    else
      $('#answer').css(color: 'red').html 'INCORRECT'

  $('#next_question').click ->
    country_capital.ask()

$(window).unload ->
  GUnload()

