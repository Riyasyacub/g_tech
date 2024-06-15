json.extract! installment, :id, :student_id, :date, :amount, :created_at, :updated_at
json.url installment_url(installment, format: :json)
