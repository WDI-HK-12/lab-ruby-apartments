require ('./models/utility.rb')
require ('./models/errors.rb')

### Apartment
class Apartment < Utility
  attr_reader :number, :rent, :square_footage, :number_of_bedrooms, :number_of_bathrooms

  # has a number, rent, square footage, number of bedrooms, and number of bathrooms
  def initialize number, rent, square_footage, number_of_bedrooms, number_of_bathrooms
    @number              = number
    @rent                = rent
    @square_footage      = square_footage
    @number_of_bedrooms  = number_of_bedrooms
    @number_of_bathrooms = number_of_bathrooms

    # has many tenants
    @tenants = []
  end

  # the list of tenants should not be modified directly
  # (bonus: actually prevent it from being modified directly)
  def tenants
    @tenants.map {|t| t.dup}
  end

  # has a method to add a tenant that raises an error if the tenant has a "bad" credit rating,
  # or if the new tenant count would go over the number of bedrooms
  def add_tenant tenant
    raise BadCreditRatingError.new tenant if tenant.credit_rating == :bad
    raise NotEnoughBedroomError.new tenant if @tenants.length == @number_of_bedrooms

    @tenants << tenant
  end

  # has a method to remove a specific tenant either by object reference
  # *or* by name (bonus: do this without checking classes),
  # which raises an error if the tenant is not found
  def remove_tenant tenant
    removed = @tenants.reject! {|t| t.name == tenant || t.inspect == tenant || t.object_id == tenant || t == tenant}
    raise NoSuchTenantError.new tenant if removed.nil?
  end

  # has a method that removes all tenants
  def remove_all_tenants
    @tenants.clear
  end

  # has an average credit score, calculated from all tenants
  def average_credit_score
    @tenants.inject(0) {|sum,t| sum + t.credit_score}.to_f / @tenants.length

    # The 2 alternative ways require looping the array twice
    #@tenants.map{|t| t.credit_score}.reduce(:+).to_f / @tenants.length
    #@tenants.map(&:credit_score).reduce(:+).to_f / @tenants.length
  end

  # has a credit rating, calculated from the average credit score using the logic below
  def credit_rating
    calculate_credit_rating average_credit_score
  end

  def has_tenants?
    @tenants.length > 0
  end
end