class DownloadJob < ApplicationJob
  queue_as :default

  def perform(*args)
    download = Download.find_by_id args.first
    raise StandardError.new "Cannot find download with ID #{options["id"]}" unless download
    download.run!
  end
end
