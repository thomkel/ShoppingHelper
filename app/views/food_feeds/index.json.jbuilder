json.array!(@food_feeds) do |food_feed|
  json.extract! food_feed, :id, :title, :description, :url, :image
  json.url food_feed_url(food_feed, format: :json)
end
