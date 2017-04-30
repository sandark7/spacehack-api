class FramesController < ApplicationController
  def update
    frame = Frame.latest
    frame.update!(frame_params)

    render status: :ok
  end

  def show
    render json: Frame.latest
  end

  def frame_params
    params.permit(:photo)
  end
end
