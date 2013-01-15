class CardsController < ApplicationController

  def show
    @card = Card.find(params[:id])
    if !current_user.blank?
      @vote = Vote.exists?(:user_id => current_user.id, :card_id => @card.id)
    end
    render 'cards/smartphone/show' if @mobile
  end

  def index
    params[:criteria] = "hoy" if params[:criteria].blank?
    case params[:criteria]
    when "hoy"
      @cards = Card.select("cards.*, coalesce(round(votes.created_at), null) hoy").joins("LEFT OUTER JOIN votes on votes.card_id = cards.id and votes.created_at between '#{DateTime.now.beginning_of_day.to_s(:db)}' and '#{DateTime.now.end_of_day.to_s(:db)}'").order("hoy desc, votos desc").limit(100).all
    when "estaSemana"
      @cards = Card.select("cards.*, coalesce(round(votes.created_at), null) hoy").joins("LEFT OUTER JOIN votes on votes.card_id = cards.id and votes.created_at between '#{DateTime.now.beginning_of_week.to_s(:db)}' and '#{DateTime.now.end_of_week.to_s(:db)}'").order("hoy desc, votos desc").limit(100).all
    when "semanaPasada"
      @cards = Card.select("cards.*, coalesce(round(votes.created_at), null) hoy").joins("LEFT OUTER JOIN votes on votes.card_id = cards.id and votes.created_at between '#{1.week.ago.beginning_of_day.to_s(:db)}' and '#{1.week.ago.end_of_day.to_s(:db)}'").order("hoy desc, votos desc").limit(100).all
    when "esteMes"
      @cards = Card.select("cards.*, coalesce(round(votes.created_at), null) hoy").joins("LEFT OUTER JOIN votes on votes.card_id = cards.id and votes.created_at between '#{DateTime.now.beginning_of_month.to_s(:db)}' and '#{DateTime.now.end_of_month.to_s(:db)}'").order("hoy desc, votos desc").limit(100).all
    when "dePaSiempre"
      @cards = Card.find(:all, :order => "votos desc", :limit => 100)
    else
      @cards = Card.find(:all, :order => "votos desc", :limit => 100)
    end
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
