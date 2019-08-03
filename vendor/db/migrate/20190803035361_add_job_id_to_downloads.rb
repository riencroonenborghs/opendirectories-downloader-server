class AddJobIdToDownloads < ActiveRecord::Migration[5.2]
  def change
    add_column :downloads, :job_id, :text
  end
end
