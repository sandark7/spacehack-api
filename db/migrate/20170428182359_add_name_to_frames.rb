class AddNameToFrames < ActiveRecord::Migration[5.0]
  def change
    add_column :frames, :name, :string
  end
end
