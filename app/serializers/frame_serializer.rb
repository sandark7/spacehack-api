class FrameSerializer < ActiveModel::Serializer
  attributes :id, :photo_url, :name, :focal_points, :box

  def box
    {
      top_left_x: object.box.top_left.x,
      top_left_y: object.box.top_left.y,
      bottom_right_x: object.box.bottom_right.x,
      bottom_right_y: object.box.bottom_right.x
    }
  end

  def photo_url
    object.photo.url
  end
end
