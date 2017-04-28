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
  mount_uploader :photo, FrameUploader

  before_save :process_image, if: :fixture?

  def process_image
    remote_photo_url = ebay_url
  end

  def fixture?
    ebay_url.present?
  end
end
