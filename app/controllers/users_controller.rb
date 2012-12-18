class UsersController < ApplicationController

  def create
    @cards = Card.all
  end
  
end
