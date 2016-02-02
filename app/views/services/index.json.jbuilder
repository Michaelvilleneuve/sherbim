json.array!(@services) do |service|
  json.extract! service, :id, :user_id, :title, :description, :place, :transport, :statut, :price, :date, :code
  json.url service_url(service, format: :json)
end
