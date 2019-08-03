class RemoveUniqueKeyOnDownloads < ActiveRecord::Migration[5.2]
  def change
    remove_index :downloads, [:user_id, :url]
  end
end
