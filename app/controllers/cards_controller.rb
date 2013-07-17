class CardsController < ApplicationController

  def show
    @card = Card.find(params[:id])
    @comments = Comment.find_all_by_card_id(@card.id)
    if !current_user.blank?
      @vote = Vote.exists?(:user_id => current_user.id, :card_id => @card.id)
    end
    render 'cards/smartphone/show' if @mobile
  end

  def index
    params[:criteria] = "" if params[:criteria].blank?
    params[:page] = 1 if params[:page].blank?
    @criteria = params[:criteria]
    @tag = params[:tag]
    @card = get_cards(params[:criteria], params[:page], params[:tag])
    if !current_user.blank?
      @votes = Vote.where(:user_id => current_user.id, :card_id => @cards.collect(&:id)).pluck(:card_id)
    end
    render 'cards/smartphone/index' if @mobile
  end

  def index_ajax
    @cards = get_cards(params[:criteria],params[:page])
    render :index_ajax, :layout => false
  end

  def nuevos
    if !Rails.env.production?
      @cards = Card.find(:all, :order => "created_at desc", :limit => 5)
    else
      @cards = Card.find(:all, :order => "created_at desc", :limit => 50)
    end
    
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
    height = params[:card_height].to_i
    height = 380 if height<380
    @card = Card.new(:picture_id => picture_id, :height => height, :user_id => current_user.id, :comment => params[:cromoText], :votos => 0)
    @card.tag_list = params[:tags] if !params[:tags].blank?
    @card.save
    redirect_to card_path @card and return if @mobile
    redirect_to "/cromosImagen/#{picture_id}"
  end

  private
  def get_cards(criteria, page = 1, tag)
    offset = (page.to_i - 1) * 50
    if !Rails.env.production?
      if tag.blank?
        @cards = Card.all(:order => "votos desc", :limit => 5, :offset => (page.to_i-1) * 5)
      else
        @cards = Card.tagged_with(tag).order("votos desc").limit(5).offset((page.to_i-1) * 5)
      end
    else
      select = "cards.*,coalesce(extract(YEAR FROM votes.created_at), null) hoy"
      joins=""
      order = "hoy, votos desc"
      case criteria
      when "hoy"
        joins = "LEFT OUTER JOIN votes on votes.card_id = cards.id and votes.created_at between '#{DateTime.now.beginning_of_day.to_s(:db)}' and '#{DateTime.now.end_of_day.to_s(:db)}'"
      when "estaSemana"
        joins = "LEFT OUTER JOIN votes on votes.card_id = cards.id and votes.created_at between '#{DateTime.now.beginning_of_week.to_s(:db)}' and '#{DateTime.now.end_of_week.to_s(:db)}'"
      when "semanaPasada"
        joins = "LEFT OUTER JOIN votes on votes.card_id = cards.id and votes.created_at between '#{1.week.ago.beginning_of_day.to_s(:db)}' and '#{1.week.ago.end_of_day.to_s(:db)}'"
      when "esteMes"
        joins = "LEFT OUTER JOIN votes on votes.card_id = cards.id and votes.created_at between '#{DateTime.now.beginning_of_month.to_s(:db)}' and '#{DateTime.now.end_of_month.to_s(:db)}'"
      when "dePaSiempre"
        select = "*"
        order = "votos desc"
        # @cards = Card.find(:all, :order => "votos desc", :limit => 50, :offset => offset)
      else
        select = "*"
        order = "cards.created_at desc"
        #@cards = Card.find(:all, :order => "created_at desc", :limit => 50, :offset => offset)
      end
      if tag.blank?
        if !joins.blank?
          @cards = Card.select(select).joins(joins).order(oder).limit(50).offset(offset).all.uniq
        else
          @cards = Card.select(select).limit(50).order(order).offset(offset).all.uniq
        end
      else
        if !joins.blank?
          @cards = Card.tagged_with(tag).select(select).joins(joins).limit(50).order(order).offset(offset).all.uniq
        else
          @cards = Card.tagged_with(tag).select(select).limit(50).order(order).offset(offset).all.uniq
        end      
      end

    end
  end
end
