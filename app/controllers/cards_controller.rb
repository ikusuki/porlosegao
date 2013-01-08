class CardsController < ApplicationController

  def index
    @cards = Card.find(:all, :order => "votos desc", :limit => 100)
    if !current_user.blank?
      @votes = Vote.where(:user_id => current_user.id, :card_id => @cards.collect(&:id)).pluck(:card_id)
    end
    render 'cards/smartphone/index' if @mobile
  end

  def nuevos
    @cards = Card.find(:all, :order => "created_at desc", :limit => 100)
    if !current_user.blank?
      @votes = Vote.where(:user_id => current_user.id, :card_id => @cards.collect(&:id)).pluck(:card_id)
    end
    render 'cards/smartphone/index' and return if @mobile
    render 'index'
  end

  def from_picture
    @picture = Picture.find(params[:id])
    @cards = Card.order("created_at desc").where(:picture_id => params[:id])
    if !current_user.blank?
      @votes = Vote.where(:user_id => current_user.id, :card_id => @cards.collect(&:id)).pluck(:card_id)
    end

  end
  
  def create_cromo
    #todo: error management
    picture_id = params[:picture_id]
    Card.create(:picture_id => picture_id, :height => params[:card_height], :user_id => current_user.id, :comment => params[:cromoText], :votos => 0)
    redirect_to "/cromosImagen/#{picture_id}"
  end

end
