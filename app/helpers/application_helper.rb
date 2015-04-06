module ApplicationHelper

  def date_or_time(created_at)
    created_at > Date.today.beginning_of_day ? created_at.localtime.strftime('%I:%M%P') : created_at.localtime.strftime('%d %b')
  end

  def duration(duration)
    hours   = (duration/360).to_i
    minutes = ((duration - (hours*360))/60).to_i
    seconds = (duration - (hours*360) - (minutes*60)).to_i
    "#{pad(hours)}:#{pad(minutes)}:#{pad(seconds)}"
  end

  def pad(number)
    number < 10 ? "0#{number}" : number
  end
end
