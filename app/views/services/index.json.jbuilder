json.array!(@services) do |service|
  json.extract! service, :title, :description, :place, :transport, :statut, :price, :date, :latitude, :longitude
  json.url service_url(service, format: :json)
end
