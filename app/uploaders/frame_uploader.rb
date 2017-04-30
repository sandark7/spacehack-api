class FrameUploader < CarrierWave::Uploader::Base
  storage :file

  def cache_dir
    '/tmp/images_cache'
  end
end
