require ('./models/utility.rb')
require ('./models/errors.rb')

### Building
class Building
  include Utility

  attr_reader :address, :apartments

  # has an address
  def initialize address
    @address = address

    # has many apartments
    @apartments = []
  end

  # has a method to add an apartment
  def add_apartment apartment
    @apartments << apartment
  end

  def remove_apartment apartment_number, force_removal = false
    apartment = get_apartment apartment_number
    raise ApartmentOccupiedError.new apartment if !force_removal && apartment.has_tenants?

    @apartments.delete apartment
  end

  # has a total square footage, calculated from all apartments
  def total_square_footage
    @apartments.inject(0) {|sum,a| sum + a.square_footage}
  end

  # has a total monthly revenue, calculated from all apartment rents
  def total_monthly_revenue
    @apartments.inject(0) {|sum,a| sum + a.rent}
  end

  # has a list of tenants, pulled from the tenant lists of all apartments
  def all_tenants
    @apartments.map(&:tenants).flatten
    # @apartments.map{|a| a.tenants }.flatten
  end

  # has a method to retrieve all apartments grouped by `credit_rating`
  # (bonus: sort the groups by credit rating from `excellent` to `bad`)
  def apartments_by_average_credit_rating
    result = {excellent: [], great: [], good: [], mediocre: [], bad: []}
    @apartments.each_with_object(result) {|a,h| h[a.credit_rating] << a}
    # @apartments.each do |a|
    #   result[a.credit_rating] << a
    # end
  end

  def has_tenants?
    !@apartments.select{|a| a.has_tenants?}.empty?
  end

  def find_apartment_index apartment_number
    index = @apartments.index { |a| a.number == apartment_number }
    raise NoSuchApartmentError.new apartment_number if index.nil?
    index
  end

  def get_apartment apartment_number
    @apartments[find_apartment_index apartment_number]
  end
end
