class AddEbayIdEndedAtEbayUrlToFrames < ActiveRecord::Migration[5.0]
  def change
    add_column :frames, :ended_at, :datetime
    add_column :frames, :ebay_url, :string
  end
end
