class FrameSerializer < ActiveModel::Serializer
  attributes :id, :photo_url, :name, :box

  def box
    # if object.photo && object.photo.url
    #   {
    #     top_left_x: object.box.top_left.x,
    #     top_left_y: object.box.top_left.y,
    #     bottom_right_x: object.box.bottom_right.x,
    #     bottom_right_y: object.box.bottom_right.x
    #   }
    # else
      {
        top_left_x: rand(200),
        top_left_y: rand(200),
        bottom_right_x: 100 + rand(200),
        bottom_right_y: 100 + rand(200)
      }
    # end
  end

  def photo_url
    object.photo.url
  end
end
