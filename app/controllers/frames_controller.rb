class FramesController < ApplicationController
  def update
    frame = Frame.latest
    # frame.update(photo: frame_params)
    render status: :ok
  end

  def show
    render json: Frame.latest
  end

  def frame_params
    params.permit(:photo)
  end
end
