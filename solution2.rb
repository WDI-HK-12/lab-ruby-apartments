# open irb and copy paste each line to test
require ('./models/building')
require ('./models/apartment')
require ('./models/tenant')

# address
b = Building.new("108 Queens Road")

# number, rent, square_footage, number_of_bedrooms, number_of_bathrooms
a  = Apartment.new(7, 500, 500, 2, 2)

# name, age, credit_score
t1 = Tenant.new("hector", 18, 700)
t2 = Tenant.new("oreo",   18, 700)
t3 = Tenant.new("blues",  18, 500)
t4 = Tenant.new("jazzy",  18, 600)

# add apartment to building
b.add_apartment(a)

# add tenants to apartment
a.add_tenant(t1)
a.add_tenant(t2)
a.add_tenant(t3)
a.add_tenant(t4)

# check credit score and rating
a.average_credit_score
a.credit_rating

# remove 1 tenant
a.remove_tenant(t1) # t1.inspect || t1.object_id || t1.name
a.tenants

# remove all tenants
a.remove_all_tenants
a.tenants

# check building stats
b.total_square_footage
b.total_monthly_revenue
b.all_tenants
b.apartments_by_average_credit_rating