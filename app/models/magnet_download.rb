class MagnetDownload < Download
  def build_command
    command     = "transmission-cli"
    unique_id   = Time.now.strftime("%Y%m%d-%H%M%S")
    kill_script = "$MYPATH/kill-torrent-#{unique_id}.sh"

    cmd = []
    
    cmd << "MYPATH=`pwd`;"
    cmd << "echo 'kill `ps a | grep transmission-cli | grep #{unique_id} | awk {\"print \\$1\"}`; rm -rf \"$0\"' > \"#{kill_script}\"; chmod +x \"#{kill_script}\";"
    cmd << command
    cmd << "-f \"#{kill_script}\""
    cmd << "-er -ep" # encrypt
    cmd << "-D" # no download limit
    cmd << "-u 10" # upload limit 10 kb/s
    cmd << " -w \"#{ENV["OUTPUT_PATH"]}\""
    cmd << "\"#{url}\"" 
    cmd.join(" ")
  end
end
