class FrameUploader < CarrierWave::Uploader::Base
  storage :aws

  def cache_dir
    '/tmp/images_cache'
  end
end
