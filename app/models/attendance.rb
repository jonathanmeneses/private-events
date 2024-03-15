class Attendance < ApplicationRecord
  belongs_to :attended_event, class_name: 'Event'
  belongs_to :attendee, class_name: 'User'

  validates :attendee_id, uniqueness: { scope: :attended_event_id }

  enum status: { attending: 0, declined: 1, maybe: 2 }

  # validates :status, presence: true

  scope :for_user, ->(user_id) { where(attendee_id: user_id) }
  scope :future, -> { joins(:attended_event).where('events.date > ?', Time.now) }
  scope :past, -> { joins(:attended_event).where('events.date < ?', Time.now) }
  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :ordered_by_event_date, -> { order('events.date ASC') }
end
