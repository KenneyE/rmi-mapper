# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: "eric@test.com", password: "foobar11")

features = ["helipad", "surgeon", "emergency room", "near water"]
features.each do |feature|
  Feature.create(name: feature)
end

10.times do |i|
  loc = Location.create(name: "Location ##{i}",
    lat: (39 + 3 * rand()).round(7),
    lon: -(104 + 3 * rand()).round(7))

    LocationFeature.create(location_id: loc.id, feature_id: [1,2,3,4].sample)

  UserLocation.create(location_id: loc.id, user_id: user.id)
end