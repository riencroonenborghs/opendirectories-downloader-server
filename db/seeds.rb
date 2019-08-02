user = User.first

user.downloads.destroy_all
Download::VALID_STATUSES.each do |status|
  r = rand(10)
  r.times do |i|
    download = user.downloads.create!(url: "http://some.#{status}.#{i+1}.url.com", status: status)
    now = Time.zone.now
    if status == Download::STATUS_STARTED
      download.update_attributes!(started_at: now - r.days)
    elsif status == Download::STATUS_FINISHED
      download.update_attributes!(started_at: now - r.days, finished_at: now - (r+2).days)
    elsif status == Download::STATUS_ERROR
      download.update_attributes!(started_at: now - r.days, finished_at: now - (r+2).days, error: "Some error message #{i+1}")
    end
  end
end