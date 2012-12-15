class ApplicationController < ActionController::Base
  protect_from_forgery

  http_basic_authenticate_with :name => "bythesegao", :password => "istheway", :except => :keep_alive
end
