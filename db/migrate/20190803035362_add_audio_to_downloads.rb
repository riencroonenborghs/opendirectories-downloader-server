class AddAudioToDownloads < ActiveRecord::Migration[5.2]
  def change
    add_column :downloads, :audio_only, :boolean, default: false, null: false
    add_column :downloads, :audio_format, :string, default: "mp3", null: false
  end
end
