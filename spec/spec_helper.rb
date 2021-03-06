require 'rubygems'
require 'spork'

Spork.prefork do
 
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

 
 
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  Rspec.configure do |config|
  
    config.mock_with :rspec

    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    
    config.use_transactional_fixtures = true
    def test_sign_in(user)
     controller.sign_in(user)
    end

    def integration_sign_in(user)
      visit signin_path
      fill_in :email,    :with => user.email
      fill_in :password, :with => user.password
      click_button
    end

  end
end

Spork.each_run do
 

end







ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'



Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
 
 
  config.mock_with :rspec

 
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

 
  config.use_transactional_fixtures = true
end
