# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# kop = Station.where(name: 'Jaworzno Kopernika')
# kop.name = 'Śródmieście Kopernika'
# kop.sensor_id = 1
# kop.save

# station = Station.find_by(name: 'Jaworzno Kopernika')


# Station.create(name: 'Śródmieście Kopernika', sensor_id: 1)
# Station.create(name: 'Elektrownia Zespół Szkół', sensor_id: 2261)
# Station.create(name: 'Stadion Azotania', sensor_id: 2247)
# Station.create(name: 'Osiedle Azot', sensor_id: 2275)
# Station.create(name: 'Stara Huta', sensor_id: 2305)
# Station.create(name: 'Sulińskiego Górka', sensor_id: 2257)
# Station.create(name: 'Bory', sensor_id: 2286)
# Station.create(name: 'Byczyna', sensor_id: 2311)
# Station.create(name: 'Jeleń Kościół', sensor_id: 2290)
# Station.create(name: 'Jeleń Wygoda', sensor_id: 2953)
#
#
# Station.create(name: 'Jeziorki', sensor_id: 2604)
# Station.create(name: 'Rynek', sensor_id: 1022)
# Station.create(name: 'Plac Górników', sensor_id: 740)
# Station.create(name: 'Podłęże Ławczana', sensor_id: 756)
# Station.create(name: 'Podwale', sensor_id: 742)
# Station.create(name: 'Osiedle Stałe Basen', sensor_id: 661)
# Station.create(name: 'Dąbrowa Narodowa', sensor_id: 2502)
# Station.create(name: 'Długoszyn', sensor_id: 2883)
# Station.create(name: 'Szczakowa', sensor_id: 886)
# Station.create(name: 'Pieczyska', sensor_id: 2735)
# Station.create(name: 'Ciężkowice', sensor_id: 754)

# Station.create(name: 'Sosnowiec Jęzor', sensor_id: 2405)
# Station.create(name: 'Sosnowiec Niwka', sensor_id: 1095)
# Station.create(name: 'Sosnowiec Dańdówka', sensor_id: 815)
# Station.create(name: 'Sosnowiec Modrzejowska 1', sensor_id: 2351)
# Station.create(name: 'Sosnowiec Modrzejowska 2', sensor_id: 738)
# Station.create(name: 'Sosnowiec Grabowa', sensor_id: 696)
# Station.create(name: 'Sosnowiec Pogoń', sensor_id: 690)
# Station.create(name: 'Sosnowiec Środula', sensor_id: 560)
# Station.create(name: 'Sosnowiec Zagórze', sensor_id: 689)

# Station.create(name: 'Sosnowiec Ostrowy Górnicze', sensor_id: 697)
# Station.create(name: 'Sosnowiec Juliusz', sensor_id: 695)

# Station.create(name: 'Dąbrowa Górnicza 3 Maja', sensor_id: 448)
# Station.create(name: 'Dąbrowa Górnicza Królowej Jadwigi', sensor_id: 398)

#
# Station.create(name: 'Mysłowice Bytomska', sensor_id: 2595)
# Station.create(name: 'Mysłowice Brzozowa', sensor_id: 2566)

# Station.create(name: 'Chełm Śląski', sensor_id: 2357)


# Station.create(name: 'Mysłowice Bończyk', sensor_id: 2268)
# Station.create(name: 'Mysłowice Słupna', sensor_id: 2213)
# Station.create(name: 'Katowice ul. Dąbrówki', sensor_id: 2142)
# Station.create(name: 'Katowice Słowackiego', sensor_id: 2249)
# Station.create(name: 'Katowice 3 Maja', sensor_id: 700)
# Station.create(name: 'Katowice Plac Miarki', sensor_id: 749)
# Station.create(name: 'Katowice Panewnicka', sensor_id: 599)
# Station.create(name: 'Katowice Zbożowa', sensor_id: 2137)

#
# BlogitPost.create(title: 'First post xD', body: 'Lorem ipsum qwe')
# BlogitPost.create(title: 'Second post xD', body: 'Ram pam pam asd')


# Installation.create(name: 'Śródmieście Kopernika', sensor_id: 1)
# Installation.create(name: 'Elektrownia Zespół Szkół', sensor_id: 2261)
# Installation.create(name: 'Stadion Azotania', sensor_id: 2247)
# Installation.create(name: 'Osiedle Azot', sensor_id: 2275)
# Installation.create(name: 'Stara Huta', sensor_id: 2305)
# Installation.create(name: 'Sulińskiego Górka', sensor_id: 2257)
# Installation.create(name: 'Bory', sensor_id: 2286)
# Installation.create(name: 'Byczyna', sensor_id: 2311)
# Installation.create(name: 'Jeleń Kościół', sensor_id: 2290)
# Installation.create(name: 'Jeleń Wygoda', sensor_id: 2953)
#
#
# Installation.create(name: 'Jeziorki', sensor_id: 2604)
# Installation.create(name: 'Rynek', sensor_id: 1022)
# Installation.create(name: 'Plac Górników', sensor_id: 740)
# Installation.create(name: 'Podłęże Ławczana', sensor_id: 756)
# Installation.create(name: 'Podwale', sensor_id: 742)
# Installation.create(name: 'Osiedle Stałe Basen', sensor_id: 661)
# Installation.create(name: 'Dąbrowa Narodowa', sensor_id: 2502)
# Installation.create(name: 'Długoszyn', sensor_id: 2883)
# Installation.create(name: 'Szczakowa', sensor_id: 886)
# Installation.create(name: 'Pieczyska', sensor_id: 2735)

# Installation.create(name: 'Ciężkowice', sensor_id: 754)
# Measurement.create(pm10: 0, pm25: 0, installation_id: Installation.last.id)
Setting.title = "Tytuł aplikacji"
Setting.subtitle = "w Naszym Mieście"
