class Download < ApplicationRecord
  STATUS_INITIAL    = "initial"
  STATUS_QUEUED     = "queued"
  STATUS_STARTED    = "started"
  STATUS_FINISHED   = "finished"
  STATUS_ERROR      = "error"
  STATUS_CANCELLED  = "cancelled"
  VALID_STATUSES    = [STATUS_INITIAL, STATUS_QUEUED, STATUS_STARTED, STATUS_FINISHED, STATUS_ERROR, STATUS_CANCELLED]

  belongs_to :user

  validates_presence_of :url
  # validates_format_of :url, with: URI::regexp(%w(http https ftp magnet))
  validates_inclusion_of :status, in: VALID_STATUSES
  validates_inclusion_of :audio_format, in: ["best", "aac", "flac", "mp3", "m4a", "opus", "vorbis", "wav"]
  validate :http_credentials

  scope :last_n,    lambda { |n| order(id: :desc).limit(n) }
  scope :last_10,   -> { order(id: :desc).limit(10) }
  scope :initial,   -> { where(status: STATUS_INITIAL) }
  scope :queued,    -> { where(status: STATUS_QUEUED) }
  scope :started,   -> { where(status: STATUS_STARTED) }
  scope :finished,  -> { where(status: STATUS_FINISHED) }
  scope :error,     -> { where(status: STATUS_ERROR) }
  scope :cancelled, -> { where(status: STATUS_CANCELLED) }
  scope :for_clearing, -> { where(status: [STATUS_FINISHED, STATUS_ERROR, STATUS_CANCELLED] ) }

  def self.latest
    [initial.last_n(5), queued.last_n(5), started.last_n(5), finished.last_n(5), error.last_n(5)].compact.flatten
  end

  def enqueue!    
    return if queued? || started?
    DownloadJob.perform_later self.id
    queue!
  end

  def queue!
    update(status: STATUS_QUEUED, queued_at: Time.zone.now, started_at: nil, finished_at: nil, error: nil)
  end

  def queued?
    status == STATUS_QUEUED
  end

  def start!    
    update(status: STATUS_STARTED, started_at: Time.zone.now, finished_at: nil, error: nil)
  end

  def started?
    status == STATUS_STARTED
  end

  def finish!
    update(status: STATUS_FINISHED, finished_at: Time.zone.now)
  end

  def error!(message)
    update(status: STATUS_ERROR, finished_at: Time.zone.now, error: message)
  end

  def cancel!
    update(status: STATUS_CANCELLED, cancelled_at: Time.zone.now)
  end

  def cancelled?
    status == STATUS_CANCELLED
  end

  def reload_proper!
    DownloaderService.find self.id
  end

  def to_json
    hash = Hash.new.tap do |ret|
      attributes.map do |key, value|
        ret[key] = value
      end
    end
    hash["user"] = {id: user_id, email: user.email}
    hash
  end

  def to_youtube
    YoutubeDownload.find self.id
  end

  def to_magnet
    MagnetDownload.find self.id
  end

  def to_opendir
    OpendirDownload.find self.id
  end

  private

  def http_credentials
    errors.add(:http_username, "no HTTP password set") if http_username.present? && !http_password.present?
    errors.add(:http_password, "no HTTP username set") if http_password.present? && !http_username.present?
  end
end
