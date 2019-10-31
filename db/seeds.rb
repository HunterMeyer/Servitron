User.find_or_initialize_by(email: 'dev@example.com').tap do |user|
  user.first_name = 'Dev'
  user.last_name  = 'Example'
  user.status     = 'Active'
  user.save!
  user.enable_api
  ap user.api_key
end
