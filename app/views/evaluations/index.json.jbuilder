json.array!(@evaluations) do |evaluation|
  json.extract! evaluation, :id, :evaluation_code_id, :opportunity_id, :team_id
  json.url evaluation_url(evaluation, format: :json)
end
