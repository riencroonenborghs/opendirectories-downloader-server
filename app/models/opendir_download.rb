class OpendirDownload < Download
  def build_command
    cmd = ["wget"]
    cmd << "-c --reject \"index.html*\" -r -np -e robots=off --random-wait"
    cmd << "--http-user=\"#{http_username}\" --http-password=\"#{http_password}\" " if http_username && http_password
    cmd << "--accept \"#{file_filter}\"" if file_filter.present?
    cmd << "--no-check-certificate"
    cmd << "--directory-prefix=\"#{ENV["OUTPUT_PATH"]}\""
    cmd << "\"#{url}\""
    cmd.join(" ")
  end
end
