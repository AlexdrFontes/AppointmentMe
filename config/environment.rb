# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => ENV['SENDGRID_API'],
  :domain => 'test.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain
}

ActionMailer::Base.delivery_method = :smtp
