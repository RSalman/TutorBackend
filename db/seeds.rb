# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
    {'name': 'Sarmad Hashmi', 'email': 'sarmad@test.com', 'uid': '12345'},
    {'name': 'Peng Liu', 'email': 'peng@test.com', 'uid': '12346'}
                    ])

courses = Course.create([
    {'course_prefix': 'CSI', 'course_code': '2132', 'course_name': 'Database I'},
    {'course_prefix': 'CSI', 'course_code': '3131', 'course_name': 'Operating Systems'}
                        ])
