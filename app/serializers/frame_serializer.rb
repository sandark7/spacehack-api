class FrameSerializer < ActiveModel::Serializer
  attributes :id, :photo_url, :name, :box

  def box
    if object.photo
      {
        top_left_x: object.box.top_left.x,
        top_left_y: object.box.top_left.y,
        bottom_right_x: object.box.bottom_right.x,
        bottom_right_y: object.box.bottom_right.x
      }
    else
      {}
    end
  end

  def photo_url
    object.photo.url
  end
end
