json.array!(@selection_criteria) do |selection_criterium|
  json.extract! selection_criterium, :id, :classification_code_id, :set_aside_id, :procurement_type_id
  json.url selection_criterium_url(selection_criterium, format: :json)
end
