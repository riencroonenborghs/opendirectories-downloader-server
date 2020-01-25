class YoutubeDownload < Download
  def build_command
    cmd = ["youtube-dl"]
    cmd << "--extract-audio --audio-format \"#{audio_format}\" --audio-quality 0" if audio_only
    cmd << "--write-sub" if download_subs
    cmd << "--convert-subs srt" if srt_subs
    cmd << "--continue --output \"#{ENV["OUTPUT_PATH"]}/%(title)s-%(id)s.%(ext)s\""
    cmd << "\"#{url}\" "
    cmd.join(" ")
  end
end
