json.array!(@classification_codes) do |classification_code|
  json.extract! classification_code, :id, :name
  json.url classification_code_url(classification_code, format: :json)
end
