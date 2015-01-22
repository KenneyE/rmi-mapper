# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(email: "eric@test.com", password: "foobar11")

feature_ids = []
features = ["helipad", "surgeon", "emergency room", "near water"]
features.each do |feature|
  f = Feature.create(name: feature)
  feature_ids << f.id
end

100.times do |i|
  hosp = Hospital.create(name: "Hospital ##{i}",
    lat: (30 + 20 * rand()).round(7),
    lon: -(90+ 30 * rand()).round(7))

    HospitalFeature.create(hospital_id: hosp.id, feature_id: feature_ids.sample)

  # UserLocation.create(location_id: loc.id, user_id: user.id)
end

5.times do |i|
  user.locations.create(name: "Fixed Location ##{i}",
    lat: (39 + 3 * rand()).round(7),
    lon: -(104 + 3 * rand()).round(7),
    location_type: "fixed")

  # UserLocation.create(location_id: loc.id, user_id: user.id)
end

5.times do |i|
  user.locations.create(name: "Ship ##{i}",
    lat: (39 + 3 * rand()).round(7),
    lon: -(104 + 3 * rand()).round(7),
    location_type: "ship")

  # UserLocation.create(location_id: loc.id, user_id: user.id)
end