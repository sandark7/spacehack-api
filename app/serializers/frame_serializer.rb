class FrameSerializer < ActiveModel::Serializer
  attributes :id, :photo_url, :name, :focal_points

  def photo_url
    object.photo.url
  end
end
