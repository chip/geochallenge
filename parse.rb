#!/usr/bin/env ruby
require 'csv'

data = "var countries = {\n"
CSV.foreach("./cow.txt", col_sep: ';') do |row|
  capital = row[38].to_s.strip
  next if capital.empty? || capital.eql?('UNen_capital')
  country = row[4].to_s.strip
  continent = row[47].to_s.strip
  latitude = row[45].to_s.strip
  longitude = row[46].to_s.strip
  data += <<-eos
  "#{country}": {
      capital: "#{capital}"
    , continent: "#{continent}"
    , latitude: "#{latitude}"
    , longitude: "#{longitude}"
  },
  eos
end
data += '};'
puts data
