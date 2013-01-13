# -*- coding: utf-8 -*- 
module CardsHelper

  def vote_class(card_id)
    return nil if current_user.blank?
    return "clicked" if !@vote.blank?
    return "clicked" if !@votes.blank? && @votes.include?(card_id)
  end

  def twitter_link(card)
    link = "https://twitter.com/intent/tweet?text=Ojo al cromo!! "
    link += "「#{card.picture.description}」" unless card.picture.description.blank?
    link += card_url(card)
  end

  def facebook_link(card)
    link = "https://facebook.com/sharer/sharer.php?u=#{card_url(card)}&t=Ojo al cromo!! "
    link += "「#{card.picture.description}」" unless card.picture.description.blank?
  end

  def line_link(card)
    link = "line://msg/text/Ojo al cromo!! "
    link += "「#{card.picture.description}」" unless card.picture.description.blank?
    link += card_url(card)
  end

end
