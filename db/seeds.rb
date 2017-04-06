# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

sample_bio = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. sheets containing Lorem Ipsum passages, and more recently with."
sample_caption = "Passionate about sharing knowledge!"

tutor = User.create!({'first_name': 'Salman', 'last_name': 'Rana', 'password': 'password',
                       'email': 'srana@uottawa.ca', 'uid': '12345', 'phone_number': '6131234567', 'tutor_description': sample_bio, 'tutor_short_description': sample_caption,
                       'agg_tutor_rating': 25, 'num_tutor_rating': 10})

test_course = Course.create!({'course_prefix': 'SEG', 'course_code': '4145', 'course_name': 'Real Time Systems'})
tutor_subject = TutorSubject.create!({'user_id': tutor.id, 'course_id': test_course.id, 'rate': 15})

tutee = User.create!({'first_name': 'Sarmad', 'last_name': 'Test', 'password': 'password',
                       'email': 'shashmi@uottawa.ca', 'uid': '12346', 'phone_number': '6131234568', 'tutor_hidden': 0})

encrypted_password = User.new(password: 'password').encrypted_password
User.bulk_insert(:first_name, :last_name, :phone_number, :encrypted_password, :email, :uid,
                 :agg_tutor_rating, :agg_user_rating, :num_tutor_rating, :num_user_rating, :tutor_description, :tutor_short_description) do |worker|
  1000.times do |i|
    worker.add(first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               agg_tutor_rating: Faker::Number.between(10, 50),
               num_tutor_rating: 10,
               agg_user_rating: Faker::Number.between(10, 50),
               num_user_rating: 10,
               phone_number: 100000 + i,
               encrypted_password: encrypted_password,
               uid: "testemail#{i}@test.com",
               email: "testemail#{i}@test.com",
               tutor_description: sample_bio,
               tutor_short_description: sample_caption)
  end
end

Course.bulk_insert do |worker|
  worker.add(course_prefix: 'CSI', course_code: '2132', course_name: 'Database I')
  worker.add(course_prefix: 'CSI', course_code: '3131', course_name: 'Operating Systems')
  worker.add(course_prefix: 'CSI', course_code: '4107', course_name: 'Information Retrieval')
  worker.add(course_prefix: 'SEG', course_code: '4910', course_name: 'Capstone (Part 1)')
  worker.add(course_prefix: 'SEG', course_code: '4911', course_name: 'Capstone (Part 2)')
  worker.add(course_prefix: 'CEG', course_code: '3185', course_name: 'Data communications')
end

user_ids = User.pluck(:id)
course_ids = Course.pluck(:id)

TutorSubject.bulk_insert(:course_id, :user_id, :rate, ignore: true) do |worker|
  1000.times do |i|
    worker.add(course_id: course_ids.sample,
               user_id: user_ids.sample,
               rate: rand(100) + 1)
  end
end

tutor_subject_ids = TutorSubject.pluck(:id)
tutor_ids = TutorSubject.distinct.pluck(:user_id)

PendingTutorRequest.bulk_insert(:tutor_subject_id, :student_id, :tutor_id, ignore: true) do |worker|
  200.times do
    worker.add(tutor_subject_id: tutor_subject_ids.sample,
               student_id: user_ids.sample,
               tutor_id: tutor_ids.sample)
  end
end

AcceptedTutorRequest.bulk_insert(:tutor_subject_id, :student_id, :tutor_id, ignore: true) do |worker|
  200.times do
    worker.add(tutor_subject_id: tutor_subject_ids.sample,
               student_id: user_ids.sample,
               tutor_id: tutor_ids.sample)
  end
end