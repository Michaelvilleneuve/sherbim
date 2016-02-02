json.array!(@users) do |user|
  json.extract! user, :id, :name, :firstname, :description, :email, :phone, :age, :points
  json.url user_url(user, format: :json)
end
