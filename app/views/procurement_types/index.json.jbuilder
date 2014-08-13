json.array!(@procurement_types) do |procurement_type|
  json.extract! procurement_type, :id, :name
  json.url procurement_type_url(procurement_type, format: :json)
end
