class ApplicationController < ActionController::Base
  protect_from_forgery

  http_basic_authenticate_with :name => "tosca", :password => "koki142", :except => :keep_alive
end
