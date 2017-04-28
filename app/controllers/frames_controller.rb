class FramesController < ApplicationController
  def update
    frame = Frame.latest
    frame.update!(frame_data)
    respond json: frame
  end

  def show
    render json: Frame.latest
  end

  def frame_data
    frame_params.merge(photo: frame_photo)
  end

  def frame_params
    # binding.pry
    params.require(:frame)
  end

  def frame_photo
    params.require(:upload)
  end
end
