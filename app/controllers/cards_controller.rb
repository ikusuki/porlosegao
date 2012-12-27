class CardsController < ApplicationController

  def index
    @cards = Card.find(:all, :order => "votes, id desc")
  end

  def from_picture
    @picture = Picture.find(params[:id])
    @cards = Card.order("id desc").where(:picture_id => params[:id])
  end
  
  def create_cromo
    #todo: error management
    picture_id = params[:picture_id]
    Card.create(:picture_id => picture_id, :height => params[:card_height], :user_id => current_user.id, :comment => params[:cromoText])
    redirect_to "/cromosImagen/#{picture_id}"
  end

end
