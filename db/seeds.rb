# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sarmad = User.create({'first_name': 'Sarmad', 'last_name': 'Hashmi', 'email': 'sarmad@test.com', 'password': 'test', 'phone_number': '6132185523', 'uid': '12345'})
peng = User.create({'first_name': 'Peng', 'last_name': 'Liu', 'email': 'peng@test.com', 'password': 'test', 'phone_number': '6134185523','uid': '12346'})
muraad = User.create({'first_name': 'Muraad', 'last_name': 'Hared', 'email': 'muraad@test.com', 'password': 'test', 'phone_number': '6133184753', 'uid': '12347'})

csi2132 = Course.create({'course_prefix': 'CSI', 'course_code': '2132', 'course_name': 'Database I'})
csi3131 = Course.create({'course_prefix': 'CSI', 'course_code': '3131', 'course_name': 'Operating Systems'})
csi4107 = Course.create({'course_prefix': 'CSI', 'course_code': '4107', 'course_name': 'Information Retrieval'})

sarmad_info = TutorInfo.create({'user_id': sarmad.id, 'description': '4th yr software engineering student'})
peng_info = TutorInfo.create({'user_id': peng.id, 'description': '3rd/4th yr software engineering student'})

subjects = TutorSubject.create([
    {'tutor_info_id': sarmad_info.id, 'course_id': csi2132.id, 'rate': 15},
    {'tutor_info_id': sarmad_info.id, 'course_id': csi3131.id, 'rate': 20},
    {'tutor_info_id': peng_info.id, 'course_id': csi2132.id, 'rate': 17}])
