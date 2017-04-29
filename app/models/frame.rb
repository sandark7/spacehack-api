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
  THUMBOR_HOST_URI = 'http://localhost:8081/unsafe/meta/smart/'
  mount_uploader :photo, FrameUploader

  attr_reader :box

  before_save :process_image, if: :fixture?
  scope :latest, -> { order(:updated_at).last }

  def process_image
    remote_photo_url = ebay_url
  end

  def fixture?
    ebay_url.present?
  end

  def focal_points
    thumbor_meta.dig("thumbor", "focal_points").map do |point|
      { x: point["x"], y: point["y"] }
    end
  end

  def box
    @box ||= ContourExtract.new(photo).max_box
    # puts "found external contour with bounding rectangle from #{@box.top_left.x},#{@box.top_left.y} to #{@box.bottom_right.x},#{@box.bottom_right.y}"
  end

  def thumbor_url
    "#{THUMBOR_HOST_URI}#{photo.url}"
  end

  def thumbor_meta
    @thumbor_meta ||= FaradayConnection.get(thumbor_url).body
  end
end
