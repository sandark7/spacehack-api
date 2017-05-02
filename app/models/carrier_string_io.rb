class CarrierStringIO < StringIO
  def original_filename
    # the real name does not matter
    "#{Time.now.to_i}_photo.jpeg"
  end

  def content_type
    # this should reflect real content type, but for this example it's ok
    "image/jpeg"
  end
end
