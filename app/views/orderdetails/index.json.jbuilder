json.array!(@orderdetails) do |orderdetail|
  json.extract! orderdetail, :id, :item, :amount, :price, :comment, :user_id, :order_id
  json.url orderdetail_url(orderdetail, format: :json)
end
