require ('./models/utility.rb')

### Tenant
class Tenant
  include Utility
  attr_reader :age, :credit_score, :name

  def initialize name, age, credit_score
    @name         = name
    @age          = age
    @credit_score = credit_score
  end

  def credit_rating
    self.calculate_credit_rating credit_score
  end
end