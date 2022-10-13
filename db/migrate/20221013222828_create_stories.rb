class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :by
      t.integer :total_comment_count
      t.string :hn_story_id
      t.integer :score
      t.string :time
      t.text :title
      t.text :url

      t.timestamps
    end
  end
end
