json.array!(@opportunities) do |opportunity|
  json.extract! opportunity, :id, :opportunity, :agency, :opp_type, :post_date, :response_date, :link, :comments, :like
  json.url opportunity_url(opportunity, format: :json)
end
