json.array!(@users) do |user|
  json.extract! user, :id, :name, :password, :email, :image
  json.url user_url(user, format: :json)
end
