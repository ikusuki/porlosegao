class CardsController < ApplicationController

  def index
    @cards = Card.find(:all, :order => "id desc")
  end

  def from_picture
    @picture = Picture.find(params[:id])
    @cards = Card.where(:picture_id => params[:id])
  end
  
end
