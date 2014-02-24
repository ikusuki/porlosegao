class UsersController < ApplicationController

  def create
    @cards = Card.all
  end

  def vote_card
    card = Card.find(params[:card_id])
    user_id = current_user.id
    vote = Vote.where(:user_id => user_id, :card_id => card.id).first
    if vote.blank?
      vote = Vote.create!(:user_id => user_id, :card_id => card.id)
      if card.votos.nil?
        card.votos=1
      else
        card.votos+=1
      end
      card.save
    else
      vote.destroy
      card.votos-=1
      card.save
    end
    render :json => {:votos => card.votos.to_s.rjust(3,'0'), :id => card.id}, :success => true and return
  end
end
