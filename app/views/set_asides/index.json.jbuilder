json.array!(@set_asides) do |set_aside|
  json.extract! set_aside, :id, :name
  json.url set_aside_url(set_aside, format: :json)
end
