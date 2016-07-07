module Utility
  def calculate_credit_rating credit_score
    case credit_score
      when 0..559 then :bad
      when 560..659 then :mediocre
      when 660..724 then :good
      when 725..759 then :great
      else :excellent
    end
  end
end