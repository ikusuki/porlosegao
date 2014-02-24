class ApplicationController < ActionController::Base
  protect_from_forgery

  # http_basic_authenticate_with :name => "bythesegao", :password => "istheway", :except => :keep_alive
  before_filter :is_mobile
  layout :which_layout

  def is_mobile
    @mobile = detect_mobile_browser
  end

  def which_layout
    @mobile ? "mobile" : "application"
  end

  def after_sign_in_path_for(resource_or_scope)
    session[:just_login] = true
    root_path
  end

  def after_sign_up_path_for(resource_or_scope)
    session[:just_register] = true
    root_path
  end

  private

  MOBILE_BROWSERS = ["playbook", "windows phone", "android", "ipod", "iphone", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

  def detect_mobile_browser
    agent = request.headers["HTTP_USER_AGENT"].downcase

    MOBILE_BROWSERS.each do |m|
      return true if agent.match(m)
    end
    return false
  end

end
