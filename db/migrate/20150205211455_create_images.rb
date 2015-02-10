class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :link
      t.integer :uploader_id

      t.timestamps
    end
  end
end
