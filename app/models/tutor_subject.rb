# A tutor is willing to tutor a given course
class TutorSubject < ApplicationRecord
  validates :rate, presence: true, numericality: { greater_than: 0 }
  validates :user, presence: true
  validates :course, presence: true
  belongs_to :user
  belongs_to :course
  has_many :accepted_tutor_requests
  has_many :pending_tutor_requests

  def self.tutors_by_prefix_and_code(query, last_id)
    last_id = 0 unless last_id
    query = '' unless query

    # Get the 20 tutors listed after the last_id (i.e: tutor_id) that match the query. This is known as
    # keyset pagination. The other option is to use OFFSET and LIMIT. Keyset pagination is far more
    # efficient because OFFSET/LIMIT load, say all 1000 records before loading records 1000-1020, while
    # keyset pagination only loads records 1000-1020.
    # TODO: Check against lowercase course_prefix and course_code
    base = Course.joins(tutor_subjects: :user)
                 .group('tutor_subjects.user_id')
                 .select('users.id, users.first_name, users.agg_tutor_rating,
                         users.num_tutor_rating, AVG(tutor_subjects.rate) AS average_rate, users.image')
                 .where('tutor_subjects.deleted_at IS NULL')
                 .where('tutor_subjects.user_id > ' + last_id.to_s)
                 .limit(20)
    /(?<prefix>[[:alpha:]]*)[[:space:]]*(?<code>[[:digit:]]*)/ =~ query
    base = base.where(course_prefix: prefix) unless prefix.empty?
    base = base.where(course_code: code) unless code.empty?
    base
  end

  # Deletes TutorSubjects by setting the deleted_at field to CURRENT_TIMESTAMP
  # Takes a single argument to delete a TutorSubject by id
  # Takes two arguments to delete a TutorSubject by user_id and course_id
  def self.hide_subject(*args)
    if args.length == 1
      sql = "UPDATE tutor_subjects SET deleted_at = CURRENT_TIMESTAMP WHERE deleted_at IS NULL AND id =
                 #{ActiveRecord::Base.sanitize(args[0])}"
      ActiveRecord::Base.connection.execute(sql)
    elsif args.length == 2
      sql = "UPDATE tutor_subjects SET deleted_at = CURRENT_TIMESTAMP WHERE deleted_at IS NULL AND user_id =
             #{ActiveRecord::Base.sanitize(args[0])} AND course_id = #{ActiveRecord::Base.sanitize(args[1])}"
      ActiveRecord::Base.connection.execute(sql)
    end
  end
end
