
class EarthquakesController < ApplicationController
  def index
    # verifica que los parametros sean validos y si no lo son los reemplaza por valores por defecto
    # asegurando que si se pasan parametros invalidos devuelva solo los primeros 25 items para no sobrecargar la api
    pp "mag_type: #{params[:mag_type]}"
    pp %w[md ml ms mw me mi mb mlg].include?(params[:mag_type])
    current_page = (params[:page] && params[:page].to_i >= 1) ? params[:page].to_i : 1
    per_page = (params[:per_page] && (params[:per_page].to_i <= 1000 && params[:per_page].to_i >= 1)) ? params[:per_page].to_i : (params[:per_page].to_i > 1000 ? 1000 : 25)
    mag_type = params[:mag_type] ? params[:mag_type] : nil
    total = Earthquake.count
    @earthquakes = mag_type == nil ? Earthquake.all.order(:id).limit(per_page).offset((current_page - 1) * per_page) : Earthquake.where(mag_type: mag_type).order(:id).limit(per_page).offset((current_page - 1) * per_page)
data = @earthquakes.map do |earthquake|
  {
    id: earthquake.id,
    type: earthquake.type,
    attributes: {
      external_id: earthquake.external_id,
      magnitude: earthquake.magnitude,
      place: earthquake.place,
      time: earthquake.time,
      tsunami: earthquake.tsunami,
      mag_type: earthquake.mag_type,
      title: earthquake.title,
    },
    coordinates: {
      longitude: earthquake.longitude,
      latitude: earthquake.latitude
    },
    links: {
      external_url: earthquake.external_url
  }
  }
end
 # Configurando los encabezados de respuesta
 response.headers['Content-Type'] = 'application/vnd.api+json'
 response.headers['Cache-Control'] = 'no-cache'
 if @earthquakes.empty?
    render json: {status: 'ERROR', message: 'No earthquakes found', data: []}, status: :not_found
 else
  render json: {
                  data: data,
                  pagination: {
                    current_page: current_page,
                    total: total,
                    per_page: per_page,
                 }
                }, status: :ok
 end

end
end
