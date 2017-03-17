# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sarmad = User.create!({'first_name': 'Sarmad', 'last_name': 'Hashmi', 'password': 'password',
                       'email': 'sarmad@test.com', 'uid': '12345', 'phone_number': '6131234567'})
peng = User.create!({'first_name': 'Peng', 'last_name': 'Liu', 'password': 'password','email': 'peng@test.com',
                     'uid': '12346', 'phone_number': '6131234568'})
muraad = User.create!({'first_name': 'Muraad', 'last_name': 'Hared', 'password': 'password', 'email': 'muraad@test.com',
                       'uid': '12347', 'phone_number': '6131234569'})

csi2132 = Course.create!({'course_prefix': 'CSI', 'course_code': '2132', 'course_name': 'Database I'})
csi3131 = Course.create!({'course_prefix': 'CSI', 'course_code': '3131', 'course_name': 'Operating Systems'})
csi4107 = Course.create!({'course_prefix': 'CSI', 'course_code': '4107', 'course_name': 'Information Retrieval'})


subjects = TutorSubject.create!([
    {'user_id': sarmad.id, 'course_id': csi2132.id, 'rate': 15},
    {'user_id': sarmad.id, 'course_id': csi3131.id, 'rate': 20},
    {'user_id': peng.id, 'course_id': csi2132.id, 'rate': 17}])

pending_requests = PendingTutorRequest.create!([
    {'tutor_subject_id': subjects[0].id, 'student_id': peng.id, 'tutor_id': sarmad.id},
    {'tutor_subject_id': subjects[1].id, 'student_id': peng.id, 'tutor_id': sarmad.id}
])

accepted_requests = AcceptedTutorRequest.create!([
    {'tutor_subject_id': subjects[2].id, 'student_id': sarmad.id, 'tutor_id': peng.id}
])
