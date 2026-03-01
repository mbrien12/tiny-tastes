Plan.find_or_create_by!(name: "Starter") do |p|
  p.meals_per_week = 5
  p.price_pence    = 2999
  p.description    = "Perfect for first flavours: 5 single-portion meals introducing new tastes and textures."
end

Plan.find_or_create_by!(name: "Growing") do |p|
  p.meals_per_week = 10
  p.price_pence    = 4999
  p.description    = "Ideal for curious eaters: a varied weekly menu that grows alongside your baby."
end

Plan.find_or_create_by!(name: "Family") do |p|
  p.meals_per_week = 15
  p.price_pence    = 6999
  p.description    = "Our most popular plan: 15 meals for a full week of fuss-free mealtimes."
end

puts "Seeded #{Plan.count} plans."
