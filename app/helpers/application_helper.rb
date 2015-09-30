module ApplicationHelper
  def status_class(status)
    case status
      when :unavailable
        "card-default"
      when :passed
        "card-success"
      when :waiting
        "card-in-progress"
      else # :failed
        "card-failure"
    end
  end

  def status_text(status)
    case status
      when :unavailable
        "Project does not have a CI status"
      when :passed
        "All specs passing on Master branch"
      when :waiting
        ""
      else # :failed
        "A few specs failing on Master branch"
    end
  end
end
