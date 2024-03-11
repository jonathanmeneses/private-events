class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :attendances


  scope :past, -> {where("date < ?",DateTime.now)}
  scope :future, -> {where("date > ?", DateTime.now)}
  scope :by_creator, ->(creator_id) { where(creator_id: creator_id) }
  scope :open_invite, -> {where(invite_only: [false,nil])}
  # .or(where(invite_only: nil))}
  scope :invite_only, -> {where(invite_only: true)}
  scope :attended_by_user, ->(user_id) {Event.where(id: Attendance.select(:attended_event_id).where(attendee_id: user_id))}
end
