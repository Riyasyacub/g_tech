json.extract! course, :id, :name, :code, :total_fee, :created_at, :updated_at
json.url course_url(course, format: :json)
