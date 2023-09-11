json.extract! stress_record, :id, :user_id, :stress_relief_date, :title, :detail, :before_stress_level, :after_stress_level, :impression, :created_at, :updated_at
json.url stress_record_url(stress_record, format: :json)
