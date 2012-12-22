class PicturesController < ApplicationController

  def index
    @pictures = Picture.find(:all, :order => "id desc")
  end

  def create
    url = "https://bythesegao.s3.amazonaws.com/" + params[:url]
    picture = Picture.create(:user_id => current_user.id, :url => url)
    render :json => {:id => picture.id} and return
  end

  
end
