json.array!(@invitations) do |invitation|
  json.extract! invitation, :id, :is_join, :user_id, :order_id
  json.url invitation_url(invitation, format: :json)
end
