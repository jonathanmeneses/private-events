class Attendance < ApplicationRecord
  belongs_to :attended_event, class_name: 'Event'
  belongs_to :attendee, class_name: 'User'

  validates :attendee_id, uniqueness: { scope: :attended_event_id }

  enum status: { attending: 0, not_attending: 1, maybe: 2 }

  validates :status, presence: true
end