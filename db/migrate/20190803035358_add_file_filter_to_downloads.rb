class AddFileFilterToDownloads < ActiveRecord::Migration[5.2]
  def change
    add_column :downloads, :file_filter, :string
  end
end
