class FrameSerializer < ActiveModel::Serializer
  attributes :id, :photo_url, :name, :box

  # BIGDATA!
  def box
    # if object.photo && object.photo.url
      # {
      #   top_left_x: object.box.top_left.x,
      #   top_left_y: object.box.top_left.y,
      #   bottom_right_x: object.box.bottom_right.x,
      #   bottom_right_y: object.box.bottom_right.x
      # }
    # else
      {
        top_left_x: 280,
        top_left_y: 100,
        bottom_right_x: 650,
        bottom_right_y: 900
      }
    # end
  end

  def photo_url
    object.photo.url
  end
end
