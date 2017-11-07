json.extract! event, :id, :start_date, :end_date, :longitude, :latitude, :organisation_id, :created_at, :updated_at
json.url event_url(event, format: :json)
