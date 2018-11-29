json.extract! stat, :id, :pm10, :pm25, :day, :station_id, :created_at, :updated_at
json.url stat_url(stat, format: :json)
