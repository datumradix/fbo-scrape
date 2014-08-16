json.array!(@set_aside_radios) do |set_aside_radio|
  json.extract! set_aside_radio, :id, :name
  json.url set_aside_radio_url(set_aside_radio, format: :json)
end
