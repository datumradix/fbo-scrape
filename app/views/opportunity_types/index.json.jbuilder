json.array!(@opportunity_types) do |opportunity_type|
  json.extract! opportunity_type, :id, :name
  json.url opportunity_type_url(opportunity_type, format: :json)
end
