class ApplicationController < ActionController::Base
  protect_from_forgery

  http_basic_authenticate_with :name => "bythesegao", :password => "istheway", :except => :keep_alive

  def after_sign_in_path_for(resource_or_scope)
    session[:just_login] = true 
    root_path
  end

  def after_sign_up_path_for(resource_or_scope)
    session[:just_register] = true
    root_path
  end
end
