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
    base = Course.joins(tutor_subjects: :user)
                 .group('tutor_subjects.user_id')
                 .select('users.id, users.first_name, users.agg_tutor_rating,
                         users.num_tutor_rating, AVG(tutor_subjects.rate) AS average_rate')
                 .where('tutor_subjects.deleted_at IS NULL')
                 .where('tutor_subjects.user_id > ' + last_id.to_s)
                 .limit(20)
    /(?<prefix>[[:alpha:]]*)[[:space:]]*(?<code>[[:digit:]]*)/ =~ query
    base = base.where(course_prefix: prefix) unless prefix.empty?
    base = base.where(course_code: code) unless code.empty?
    base
  end
end
