class DownloadJob < ApplicationJob
  queue_as :default

  def perform(*args)
    download = DownloaderService.find args.first
    raise StandardError, "Cannot find download with ID #{args.first}" unless download

    service = DownloaderService.new download
    service.perform!
  end
end
