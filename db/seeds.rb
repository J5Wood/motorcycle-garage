
User.create(username: "Joe", password: "secret_password")
User.create(username: "Moe", password: "secret_password")
User.create(username: "Toe", password: "secret_password")


Brand.create(name: "Honda", year: 1955, headquarters: "Japan")
Brand.create(name: "Yamaha", year: 1955, headquarters: "Japan")
Brand.create(name: "Suzuki", year: 1952, headquarters: "Japan")
Brand.create(name: "Kawasaki", year: 1963, headquarters: "Japan")
Brand.create(name: "Ducati", year: 1926, headquarters: "Italy")
Brand.create(name: "Triumph", year: 1983, headquarters: "United Kingdom")
Brand.create(name: "Harley Davidson", year: 1903, headquarters: "USA")


Motorcycle.create(name: "CBR1000RR", year: 2008, color: "Black", mileage: 234, brand: Brand.find_by(name: "Honda"), user: User.find_by(username: "Joe"))
Motorcycle.create(name: "ZX-14", year: 2005, color: "Black", mileage: 1311, brand: Brand.find_by(name: "Kawasaki"), user: User.find_by(username: "Joe"))
Motorcycle.create(name: "GSX-R 600", year: 2018, color: "Blue", mileage: 4132453, brand: Brand.find_by(name: "Suzuki"), user: User.find_by(username: "Joe"))
Motorcycle.create(name: "1198", year: 2012, color: "Red", mileage: 13451, brand: Brand.find_by(name: "Ducati"), user: User.find_by(username: "Moe"))
Motorcycle.create(name: "YZF R6", year: 2003, color: "Blue", mileage: 5346, brand: Brand.find_by(name: "Yamaha"), user: User.find_by(username: "Moe"))
Motorcycle.create(name: "ZX1200R", year: 2009, color: "Green", mileage: 34, brand: Brand.find_by(name: "Kawasaki"), user: User.find_by(username: "Moe"))
Motorcycle.create(name: "CRF450R", year: 2020, color: "Red", mileage: 5662, brand: Brand.find_by(name: "Honda"), user: User.find_by(username: "Moe"))
Motorcycle.create(name: "XT 200", year: 2013, color: "Blue", mileage: 24562435, brand: Brand.find_by(name: "Yamaha"), user: User.find_by(username: "Toe"))
Motorcycle.create(name: "Sportster", year: 1924, color: "Black", mileage: 456, brand: Brand.find_by(name: "Harley Davidson"), user: User.find_by(username: "Toe"))
Motorcycle.create(name: "Daytona 675", year: 2006, color: "Gold", mileage: 23452, brand: Brand.find_by(name: "Triumph"), user: User.find_by(username: "Toe"))


