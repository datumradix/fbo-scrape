json.array!(@evaluation_codes) do |evaluation_code|
  json.extract! evaluation_code, :id, :name
  json.url evaluation_code_url(evaluation_code, format: :json)
end
