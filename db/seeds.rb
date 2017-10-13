# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

education = ["Masters", "PHD", "Bachelors", "High School Diploma"]

sample_bio = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. sheets containing Lorem Ipsum passages, and more recently with."
sample_short_bio = "I am a fourth year Software Engineering Student with a 9.9GPA"
sample_caption = "Passionate about sharing knowledge!"

tutor_salman = User.create!({'first_name': 'Salman', 'last_name': 'Rana', 'password': 'password',
                       'email': 'srana@uottawa.ca', 'phone_number': '6131234567', 'tutor_description': sample_bio, 'tutor_short_description': sample_caption,
                       'agg_tutor_rating': 25, 'num_tutor_rating': 10, 'education': education[0]})

tutor_sarmad = User.create!({'first_name': 'Sarmad', 'last_name': 'Hashmi', 'password': 'password',
                       'email': 'shashmi@uottawa.ca', 'phone_number': '6137410000', 'tutor_description': sample_short_bio, 'tutor_short_description': sample_caption,
                       'agg_tutor_rating': 40, 'num_tutor_rating': 10, 'education': education[1]})

tutor_muraad = User.create!({'first_name': 'Muraad', 'last_name': 'Hared', 'password': 'password',
                       'email': 'mhared@uottawa.ca', 'phone_number': '6137410001', 'tutor_description': sample_short_bio, 'tutor_short_description': sample_caption,
                       'agg_tutor_rating': 45, 'num_tutor_rating': 10, 'education': education[1]})

tutor_peng = User.create!({'first_name': 'Peng', 'last_name': 'Liu', 'password': 'password',
                       'email': 'pliu@uottawa.ca', 'phone_number': '6137410002', 'tutor_description': sample_short_bio, 'tutor_short_description': sample_caption,
                       'agg_tutor_rating': 30, 'num_tutor_rating': 10, 'education':  education[2]})

tutor_leila = User.create!({'first_name': 'Leila', 'last_name': 'Compaore', 'password': 'password',
                       'email': 'lcompaore@uottawa.ca', 'phone_number': '6137410003', 'tutor_description': sample_short_bio, 'tutor_short_description': sample_caption,
                       'agg_tutor_rating': 16, 'num_tutor_rating': 10, 'education': education[2]})

course_4145 = Course.create!({'course_prefix': 'SEG', 'course_code': '4145', 'course_name': 'Real Time Systems'})
course_4911 = Course.create!({'course_prefix': 'SEG', 'course_code': '4911', 'course_name': 'Capstone Part 2'})
course_2141 = Course.create!({'course_prefix': 'CVG', 'course_code': '2141', 'course_name': 'Civil Engineering Materials'})
course_1370 = Course.create!({'course_prefix': 'ADM', 'course_code': '1370', 'course_name': 'Applications of IT for Business'})
course_3105 = Course.create!({'course_prefix': 'CSI', 'course_code': '3105', 'course_name': 'Design and Analysis of Algorithms'})
course_2372 = Course.create!({'course_prefix': 'CSI', 'course_code': '2372', 'course_name': 'Programming Concepts With C++'})

subject1 = TutorSubject.create!({'user_id': tutor_salman.id, 'course_id': course_2372.id, 'rate': 20})
subject2 = TutorSubject.create!({'user_id': tutor_salman.id, 'course_id': course_4911.id, 'rate': 15})
subject3 = TutorSubject.create!({'user_id': tutor_sarmad.id, 'course_id': course_4145.id, 'rate': 25})
subject4 = TutorSubject.create!({'user_id': tutor_sarmad.id, 'course_id': course_3105.id, 'rate': 15})
subject5 = TutorSubject.create!({'user_id': tutor_muraad.id, 'course_id': course_1370.id, 'rate': 15})
subject6 = TutorSubject.create!({'user_id': tutor_muraad.id, 'course_id': course_3105.id, 'rate': 35})
subject7 = TutorSubject.create!({'user_id': tutor_peng.id, 'course_id': course_2372.id, 'rate': 20})
subject8 = TutorSubject.create!({'user_id': tutor_peng.id, 'course_id': course_4911.id, 'rate': 15})
subject9 = TutorSubject.create!({'user_id': tutor_leila.id, 'course_id': course_2141.id, 'rate': 25})
subject10 = TutorSubject.create!({'user_id': tutor_leila.id, 'course_id': course_3105.id, 'rate': 20})


tutee = User.create!({'first_name': 'Test', 'last_name': 'Student', 'password': 'password',
                       'email': 'student@test.com', 'phone_number': '6138459999', 'tutor_hidden': 0})

