json.array!(@solicitation_numbers) do |solicitation_number|
  json.extract! solicitation_number, :id, :name
  json.url solicitation_number_url(solicitation_number, format: :json)
end
