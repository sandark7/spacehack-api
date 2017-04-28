# == Schema Information
#
# Table name: frames
#
#  id         :integer          not null, primary key
#  photo      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ended_at   :datetime
#  ebay_url   :string
#  name       :string
#

class Frame < ApplicationRecord
end
