json.array!(@search_keywords) do |search_keyword|
  json.extract! search_keyword, :id, :team_id, :name
  json.url search_keyword_url(search_keyword, format: :json)
end
