(function() {
  var CountryCapital, Map;

  Map = (function() {

    function Map(latitude, longitude) {
      this.latitude = latitude;
      this.longitude = longitude;
      this.map = '';
      this.marker = '';
    }

    Map.prototype.load = function() {
      var coordinates;
      if (GBrowserIsCompatible()) {
        this.map = new GMap2(document.getElementById("map_canvas"));
        coordinates = new GLatLng(this.latitude, this.longitude);
        this.map.setCenter(coordinates, 8);
        this.marker = new GMarker(coordinates);
        return this.map.setUIToDefault();
      }
    };

    Map.prototype.add_marker = function() {
      return this.map.addOverlay(this.marker);
    };

    return Map;

  })();

  CountryCapital = (function() {

    function CountryCapital(country_data) {
      this.country_data = country_data;
      this.answers = {};
      this.country = '';
      this.capital = '';
      this.map = '';
    }

    CountryCapital.prototype.random = function(length) {
      return Math.floor(Math.random() * length);
    };

    CountryCapital.prototype.ask = function() {
      var countries, country, index;
      countries = Object.keys(this.country_data);
      index = this.random(countries.length);
      country = countries[index];
      this.country = this.country_data[country];
      this.capital = this.country.capital;
      console.log("lat:" + this.country.latitude + " long:" + this.country.longitude);
      console.log("country: " + country);
      console.log("capital: " + this.capital);
      this.map = new Map(this.country.latitude, this.country.longitude);
      this.map.load();
      return $('#question').html("What is the capital of " + country + "?");
    };

    return CountryCapital;

  })();

  jQuery(function() {
    var country_capital;
    country_capital = new CountryCapital(country_data);
    country_capital.ask();
    $('#submit').click(function() {
      var capital, users_answer;
      $('#answer').html('');
      users_answer = $('#users_answer').val().toLowerCase();
      capital = country_capital.capital.toLowerCase();
      if (users_answer === capital) {
        $('#answer').css({
          color: 'green'
        }).html('CORRECT');
        return country_capital.map.add_marker();
      } else {
        return $('#answer').css({
          color: 'red'
        }).html('INCORRECT');
      }
    });
    return $('#next_question').click(function() {
      return country_capital.ask();
    });
  });

  $(window).unload(function() {
    return GUnload();
  });

}).call(this);
