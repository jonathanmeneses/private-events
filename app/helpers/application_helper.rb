module ApplicationHelper
  def humanize_attendance_status(status)
    case status
    when "attending"
      "Attending"
    when "maybe"
      "Maybe Attending"
    when "declined"
      "Not Attending"
    else
      "No Response"
    end
  end
end
