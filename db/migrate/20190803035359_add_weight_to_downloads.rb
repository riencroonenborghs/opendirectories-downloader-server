class AddWeightToDownloads < ActiveRecord::Migration[5.2]
  def change
    add_column :downloads, :weight, :int, default: 9999, null: false
  end
end
