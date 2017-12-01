class DownloadProgressChannel < ApplicationCable::Channel
  def subscribed
    stream_from "download-progress-#{current_user.id}"
  end
end