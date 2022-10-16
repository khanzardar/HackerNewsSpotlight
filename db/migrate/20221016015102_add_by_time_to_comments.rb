class AddByTimeToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :by, :string
    add_column :comments, :time, :string
  end
end
