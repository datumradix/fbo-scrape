json.array!(@naics_codes) do |naics_code|
  json.extract! naics_code, :id, :name
  json.url naics_code_url(naics_code, format: :json)
end
