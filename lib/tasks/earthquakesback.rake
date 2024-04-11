# Uso: rake earthquakesback:get_earthquakes
require 'net/http'
require 'json'
require 'uri'

namespace :earthquakesback do
  desc "TODO"
  task get_earthquakes: :environment do

    failed_earthquakes = []
    not_registered_earthquakes = []
    valid_earthquakes = []
    earthquake_array=[]
    # API endpoint URL
    url = URI.parse(ENV['EQ_API']) # hay que usar .parse para que lo convierta en un objeto URI

    # Create a new HTTP request
    http = Net::HTTP.new(url.host, url.port) # Net::HTTP sirve para hacer peticiones http
    http.use_ssl = true

    # Send the GET request
    response = http.get(url) # .get es el metodo que se usa para hacer peticiones get y recibe como parametro la url

    # Parse the response body as JSON
    data = JSON.parse(response.body) # JSON.parse convierte el string en un objeto JSON

    data['features'].each do |earthquake|
      earthquake_data={
        type: "feature",
        attributes: {
        external_id: earthquake['id'],
        magnitude: earthquake['properties']['mag'].to_f,
        place: earthquake['properties']['place'],
        time: Time.at(earthquake['properties']['time'] / 1000).strftime("%Y-%m-%d %H:%M:%S"),
        tsunami: earthquake['properties']['tsunami'].to_i != 0,
        mag_type: earthquake['properties']['magType'].to_s,
        title: earthquake['properties']['title'].to_s,
        longitude: earthquake['geometry']['coordinates'][0].to_f,
        latitude: earthquake['geometry']['coordinates'][1].to_f,
        external_url: earthquake['properties']['url'].to_s,
        }
      }
      earthquake_array << earthquake_data
      if earthquake_data[:attributes][:magnitude] >= -1.0 && earthquake_data[:attributes][:magnitude] <= 10.0 && earthquake_data[:attributes][:latitude] >= -90.0 && earthquake_data[:attributes][:latitude] <= 90.0 && earthquake_data[:attributes][:longitude] >= -180.0 && earthquake_data[:attributes][:longitude] <= 180.0 && earthquake_data[:attributes][:title] != nil && earthquake_data[:attributes][:external_url] != nil && earthquake_data[:attributes][:place] != nil && earthquake_data[:attributes][:mag_type] != nil
        valid_earthquakes << earthquake_data
      else
        failed_earthquakes << earthquake_data
      end

  end

  begin
    Earthquake.create!(valid_earthquakes)
  rescue ActiveRecord::RecordInvalid => e
    not_registered_earthquakes << e.record
  end
  final= {
    registros_totales: earthquake_array.size,
    registros_creados: valid_earthquakes.size,
    no_registrados: not_registered_earthquakes.size,
    registros_no_creados: not_registered_earthquakes.size + failed_earthquakes.size,
  }
  puts final

end

end
