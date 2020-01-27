class MagnetDownload < Download
  def build_command
    command     = "transmission-cli"
    kill_script = File.join(Rails.root, "bin", "kill-transmission-cli.sh")
    unique_id   = Time.now.strftime("%Y%m%d-%H%M%S")
    unique_kill_script = "$MYPATH/kill-torrent-#{Time.now.strftime("%Y%m%d-%H%M%S")}.sh"

    cmd = []
    
    cmd << "MYPATH=`pwd`;"
    cmd << "#{kill_script} \"#{unique_kill_script}\";"
    cmd << command
    cmd << "-f \"#{unique_kill_script}\""
    cmd << "-er -ep" # encrypt
    cmd << "-D" # no download limit
    cmd << "-u 10" # upload limit 10 kb/s
    cmd << " -w \"#{ENV["OUTPUT_PATH"]}\""
    cmd << "\"#{url}\"" 
    cmd.join(" ")
  end
end
