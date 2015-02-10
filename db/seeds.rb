# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(email: "eric@test.com", password: "foobar11")
admin = User.create!(email: "admin@test.com", password: "foobar11", admin: true)

feature_ids = []
features = ["helipad", "surgeon", "emergency room", "near water", "telesurgery"]
features.each do |feature|
  f = Feature.create(name: feature)
  feature_ids << f.id
end

300.times do |i|
  hosp = Hospital.create(name: "Hospital ##{i}",
    lat: (0 + 60 * rand()).round(7),
    lon: -(70 + 70 * rand()).round(7))

    HospitalFeature.create(hospital_id: hosp.id, feature_id: feature_ids.sample)
    HospitalFeature.create(hospital_id: hosp.id, feature_id: feature_ids.sample)
    HospitalFeature.create(hospital_id: hosp.id, feature_id: feature_ids.sample)

  # UserLocation.create(location_id: loc.id, user_id: user.id)
end

5.times do |i|
  loc = user.locations.create(name: "Fixed Location ##{i}",
    lat: (10 + 50 * rand()).round(7),
    lon: -(80 + 60 * rand()).round(7),
    location_type: "fixed")

    UserLocation.create(user: admin, location: loc)
  # UserLocation.create(location_id: loc.id, user_id: user.id)
end

5.times do |i|
  loc = user.locations.create(name: "Ship ##{i}",
    lat: (10 + 50 * rand()).round(7),
    lon: -(80 + 60 * rand()).round(7),
    location_type: "ship",
    mmsi: 636013425)

    UserLocation.create(user: admin, location: loc)

  # UserLocation.create(location_id: loc.id, user_id: user.id)
end