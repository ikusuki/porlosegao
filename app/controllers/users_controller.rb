class UsersController < ApplicationController

  def create
    @cards = Card.all
  end

  def vote_card
    card = Card.find(params[:card_id])
    user_id = current_user.id
    debugger
    if Vote.where(:user_id => user_id, card_id => card.id).first.blank?
      vote = Vote.create!(:user_id => user_id, card_id => card.id)
      card.votos++
      card.save
      render :json => {:votos => @card.votos}, :success => true and return
    else
      render :json => {:msg => "Que ya has votao este cromo!!"}, :success => false and return
    end
  end
end
