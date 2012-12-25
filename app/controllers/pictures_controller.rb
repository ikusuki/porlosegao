# -*- coding: utf-8 -*- 
class PicturesController < ApplicationController
  
  def index
    @id = params[:id] if params[:id]
    @pictures = Picture.find(:all, :order => "id desc")
  end

  def create
    url = "https://bythesegao.s3.amazonaws.com/" + params[:url]
    picture = Picture.create(:user_id => current_user.id, :url => url)
    render :json => {:id => picture.id} and return
  end

  def bautizer
    id = params['id']
    debugger
    @picture = Picture.find(id)
    if current_user.id != @picture.user_id
      render :json => {:error => "Chacho, que esta imagen no es tuya"}, :success => false and return
    else
      unless params['titulo'].blank?
        @picture.update_attribute(:description, params['titulo'])
        render :json => {:titulo => params['titulo']}, :success => true and return
      end
    end
    render :json => {:error => "gñ alert!! Algo se ha roto por lo visto!!"}, :success => false
  end

  
end
