class DownloaderService
  def self.find id
    download = Download.where(id: id).first
    raise StandardError, "Cannot find download with ID #{id}" unless download
    
    case download.url
    when /youtube\.com/
      download = download.to_youtube
    when /magnet\:/
      download = download.to_magnet
    else
      download = download.to_opendir
    end

    download
  end

  def initialize(download)
    @download = download
  end

  def perform!
    prep_output_path

    begin
      return if download.cancelled?
      download.start!
      pp download.build_command
      # system download.build_command
      download.finish!
    rescue => e
      download.error! e.message
    end    
  end

  private

  def prep_output_path
    dir = ENV['OUTPUT_PATH']
    FileUtils.mkdir_p(dir) unless File.exists?(dir)
  end
end
