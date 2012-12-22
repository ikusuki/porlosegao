class CardsController < ApplicationController

  def index
    @cards = Card.all
  end

  def from_picture
    @picture = Picture.find(params[:id])
    @cards = Card.where(:picture_id => params[:id])
  end
  
end
