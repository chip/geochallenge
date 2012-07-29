class CountryCapital
  constructor: (country_data) ->
    @country_data = country_data
    @answers = {}
    @country = ''
    @capital = ''

  random: (length) ->
    Math.floor(Math.random()*length)

  ask: ->
    countries = Object.keys(@country_data)
    index = @random(countries.length)
    country = countries[index]
    @country = @country_data[country]
    @capital = @country.capital

    $('#question').html "What is the capital of #{country}?"
  

jQuery ->
  country_capital = new CountryCapital(country_data)
  country_capital.ask()

  $('#submit').click ->
    if $('#capital').val() == country_capital.capital
      $('#answer').css(color: 'green').html 'CORRECT'
      console.log(country_capital.country.latitude)
      load_map(country_capital.country.latitude, country_capital.country.longitude)
    else
      $('#answer').css(color: 'red').html 'INCORRECT'

  $('#next').click ->
    country_capital.ask()
