module CardsHelper

  def vote_class(card_id)
    return nil if current_user.blank?
    return "clicked" if !@vote.blank?
    return "clicked" if !@votes.blank? && @votes.include?(card_id)
  end

end
