require ('./models/building')
require ('./models/apartment')
require ('./models/tenant')
require ('./models/utility')
require ('pp')

class EstateManager
  attr_reader :buildings

  def initialize
    @buildings = []
  end

  def add_building address
    @buildings << Building.new(address)
  end

  def remove_building address, force_removal = false
    building = get_building address
    raise BuildingOccupiedError.new address if !force_removal && building.has_tenants?
  end

  def add_apartment_to_building address, number, rent, square_footage, number_of_bedrooms, number_of_bathrooms
    get_building(address).add_apartment Apartment.new number, rent, square_footage, number_of_bedrooms, number_of_bathrooms
  end

  def remove_apartment_from_building address, number, force_removal=false
    get_building(address).remove_apartment number, force_removal
  end

  def add_tenant_to_apartment_in_building address, number, name, age, credit_score
    get_apartment_in_building(address, number).add_tenant Tenant.new name, age, credit_score
  end

  def remove_tenant_from_apartment_in_building address, number, name
    get_apartment_in_building(address, number).remove_tenant name
  end

  def remove_all_tenants_from_apartment_in_building address, number
    get_apartment_in_building(address, number).remove_all_tenants
  end

  def total_square_footage
    @buildings.inject(0) {|sum,b| sum + b.total_square_footage}
  end

  def total_monthly_revenue
    @buildings.inject(0) {|sum,b| sum + b.total_monthly_revenue}
  end

  def all_apartments
    @buildings.map(&:apartments).flatten
  end

  def all_tenants
    @buildings.map(&:all_tenants).flatten
  end

  def find_building_index address
    index = @buildings.index {|b| b.address == address}
    raise NoSuchBuildingError.new address if index.nil?
    index
  end

  def get_building address
    @buildings[find_building_index(address)]
  end

  def get_apartment_in_building address, number
    get_building(address).get_apartment(number)
  end
end

denis_estate = EstateManager.new

denis_estate.add_building("108 Queens Road")
denis_estate.add_building("108 Kings Road")

denis_estate.add_apartment_to_building("108 Queens Road", "7A", 10000, 500, 2, 2)
denis_estate.add_apartment_to_building("108 Queens Road", "7B", 12000, 600, 2, 2)
denis_estate.add_apartment_to_building("108 Queens Road", "7C", 15000, 700, 2, 2)

denis_estate.add_apartment_to_building("108 Kings Road", "1A", 10000, 500, 2, 2)
denis_estate.add_apartment_to_building("108 Kings Road", "1B", 12000, 600, 2, 2)
denis_estate.add_apartment_to_building("108 Kings Road", "1C", 15000, 700, 2, 2)

denis_estate.add_tenant_to_apartment_in_building("108 Queens Road", "7A", "hector", 18, 700)
denis_estate.add_tenant_to_apartment_in_building("108 Queens Road", "7A", "oreo",   18, 700)
denis_estate.add_tenant_to_apartment_in_building("108 Queens Road", "7B", "blues",  18, 637)
denis_estate.add_tenant_to_apartment_in_building("108 Queens Road", "7B", "jazzy",  18, 600)

pp denis_estate