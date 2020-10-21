json.extract! account, :id, :name, :subdomain, :email_domain, :created_at, :updated_at
json.url account_url(account, format: :json)
