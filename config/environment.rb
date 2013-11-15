# Load the Rails application.
require File.expand_path('../application', __FILE__)
require "#{Rails.root}/lib/load_subcategory.rb"
require "#{Rails.root}/lib/ftp.rb"

# Initialize the Rails application.
Torca::Application.initialize!
