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

400.times do |i|
  hosp = Hospital.create(name: "Hospital ##{i}",
    lat: (-80 + 160 * rand()).round(7),
    lon: (0 + 360 * rand()).round(7))

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

mmsi_vals = [511097000, 265735000, 366709770, 367381230, 211505620]
ship_names = ["JAMILEH", "MINI STAR", "WSF CHELAN", "MATTHEW MCALLISTER", "WESERLAND"]
mmsi_vals.each_with_index do |mmsi, i|
  loc = user.locations.create(
    name: ship_names[i],
    lat: (10 + 50 * rand()).round(7),
    lon: -(80 + 60 * rand()).round(7),
    location_type: "ship",
    mmsi: mmsi)

    UserLocation.create(user: admin, location: loc)
end