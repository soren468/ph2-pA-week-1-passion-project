class CreateSimilarities < ActiveRecord::Migration
  def change
    create_table :similarities do |t|
      t.integer :first_user_id
      t.integer :second_user_id

      t.integer :calculated_similarity

      t.timestamps
    end
  end
end
