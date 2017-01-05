class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.text :title
      t.text :content_overview
      t.text :content_detail
      t.text :device
      t.text :langs
      t.text :tools
      t.text :dev_process

      t.timestamps
    end
  end
end
