json.extract! transaction, :id, :name, :kind, :value, :account_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
