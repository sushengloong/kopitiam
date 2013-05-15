json.array!(@topics) do |topic|
  json.extract! topic, :title, :text, :link
  json.url topic_url(topic, format: :json)
end