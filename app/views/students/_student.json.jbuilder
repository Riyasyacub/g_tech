json.extract! student, :id, :name, :roll_no, :address, :created_at, :updated_at
json.url student_url(student, format: :json)
