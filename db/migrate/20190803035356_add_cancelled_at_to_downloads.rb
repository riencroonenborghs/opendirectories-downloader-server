class AddCancelledAtToDownloads < ActiveRecord::Migration[5.2]
  def change
    add_column :downloads, :cancelled_at, :datetime
  end
end
