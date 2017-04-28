# == Schema Information
#
# Table name: frames
#
#  id         :integer          not null, primary key
#  photo      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ebay_id    :integer
#  ended_at   :datetime
#  ebay_url   :string
#

class Frame < ApplicationRecord
end
