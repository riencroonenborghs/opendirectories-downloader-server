class TorrentDownloadJob < ApplicationJob
  queue_as :torrents

  def perform(*args)
    download = DownloaderService.find args.first
    raise StandardError, "Cannot find download with ID #{args.first}" unless download

    service = DownloaderService.new download
    service.perform!
  end
end
